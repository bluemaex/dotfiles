# vim:ft=sh
# Test for an interactive shell - If not quit
if [[ $- != *i* ]] ; then
	return
fi

# detect operation system
case ${OSTYPE} in
	darwin*)
		MS_OS='darwin'
		MS_USER=${SUDO_USER:-${USER}}
	;;
	linux*)
		MS_OS='linux'
		MS_USER=$(stat -c %U $(readlink -f /proc/self/fd/0))
	;;
	solaris*)
		MS_OS='solaris'
		MS_USER=${SUDO_USER:-${USER}}
	;;
	*)
		MS_OS='unknown'
		MS_USER=${SUDO_USER:-${USER}}
	;;
esac

# set original user home directory
MS_HOME=${HOME}
if [ ${EUID} -eq 0 ]; then
	MS_HOME=$(grep "^${MS_USER}:" /etc/passwd | cut -d: -f 6)
	if [ -z "${MS_HOME}" ]; then
		MS_HOME=$(eval echo ~${MS_USER});
	fi
fi

# bashdir folder
MS_BASHDIR="${MS_HOME}/.bash.d"

# export all the vars
export MS_OS MS_USER MS_HOME MS_BASHDIR

# dircolors
if [[ -x $(which dircolors 2>/dev/null) ]]; then
	[[ -f /etc/DIR_COLORS ]] && eval $(dircolors -b /etc/DIR_COLORS)
	[[ -f ${MS_HOME}/.dir_colors ]] && eval $(dircolors -b ${MS_HOME}/.dir_colors)
fi

# load special files
if [ -d "${MS_BASHDIR}" ]; then
	for FILE in options exports functions aliases colors login prompt hosts; do
		if [ -r "${MS_BASHDIR}/${FILE}" ]; then
			. ${MS_BASHDIR}/${FILE}
		fi
	done
fi
