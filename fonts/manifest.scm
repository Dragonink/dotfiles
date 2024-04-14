(define-module (fonts manifest)
  #:autoload (gnu packages fonts) (
    font-fira-code
    font-google-noto
    font-google-noto-emoji
    font-google-noto-sans-cjk
    font-google-noto-serif-cjk
  )
  #:autoload (gnu packages fontutils) (fontconfig)
  #:use-module (guix build-system font)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:export (
    fonts-manifest
    nerd-font-fira-code
  )
)

(define nerd-font-fira-code
  (package
    (name "nerd-font-fira-code")
    (version "3.2.1")
    (source (origin
      (method url-fetch)
      (uri (string-append "https://github.com/ryanoasis/nerd-fonts/releases/download/v" version "/FiraCode.zip"))
      (hash (content-hash "0qp2qsb7dxsgsrsvhfhbyv5hrqzcp1q850mrk41ld47wxjpzps2f"))
    ))

    (build-system font-build-system)

    (synopsis (package-synopsis font-fira-code))
    (description
      "Nerd Fonts patches developer targeted fonts with a high number of glyphs (icons).
Specifically to add a high number of extra glyphs from popular 'iconic fonts' such as Font Awesome, Devicons, Octicons, and others."
    )
    (home-page "https://www.nerdfonts.com")
    (license license:silofl1.1)
  )
)

(define fonts-manifest
  (packages->manifest (list
    fontconfig

    nerd-font-fira-code
    font-google-noto
    font-google-noto-emoji
    font-google-noto-sans-cjk
    font-google-noto-serif-cjk
  ))
)

fonts-manifest
