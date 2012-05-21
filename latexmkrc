# generate pdf and run skim as pdfviewer
$pdf_mode = 1;
$pdflatex = 'pdflatex -file-line-error -halt-on-error -synctex=1 %O %S';
$pdf_previewer = "open -a /Applications/Skim.app";

# add some generated files-ext to cleanup
$clean_ext = "synctex.gz";

# run makeglossaries if needed
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'slg', 'syg', 'syi';
push @generated_exts, 'ist';
