(define-module (starship guix)
	#:use-module (guix build-system copy)
	#:use-module (guix download)
	#:use-module (guix gexp)
	#:use-module ((guix licenses) #:prefix license:)
	#:use-module (guix packages)
	#:export (
		starship
	)
)

(define starship
	(package
		(name "starship")
		(version "1.18.2")
		(source (origin
			(method url-fetch)
			(uri (string-append "https://github.com/starship/starship/releases/download/v" version "/starship-x86_64-unknown-linux-musl.tar.gz"))
			(hash (content-hash "0p2vwy43b13l54wv31r2503xd8rhlpaizsd5l5ydy06997m5wrpj"))
		))

		(build-system copy-build-system)
		(arguments (list
			#:install-plan #~'(
				("starship" "bin/")
			)
			#:phases #~(modify-phases %standard-phases
				(add-after 'install 'install-completions
					(lambda* (#:key outputs #:allow-other-keys)
						(let*
							(
								(out (assoc-ref outputs "out"))
								(exe (string-append out "/bin/" #$name))
								(output-completions (lambda (shell file)
								  (use-modules
										(ice-9 popen)
										(ice-9 textual-ports)
								  )

									(mkdir-p (dirname file))
									(call-with-output-file file (lambda (port)
										(let
											(
												(pipe (open-input-pipe (string-append exe " completions " shell)))
											)
											(display (get-string-all pipe) port)
											(close-pipe pipe)
										)
									))
								))
							)
					    (output-completions "bash" (string-append out "/share/bash-completion/completions/" #$name ".bash"))
					    (output-completions "zsh" (string-append out "/share/zsh/site-functions/_" #$name))
					    (output-completions "fish" (string-append out "/share/fish/completions/" #$name ".fish"))
						)
					)
				)
			)
		))

		(synopsis "A minimal, blazing fast, and extremely customizable prompt for any shell")
		(description synopsis)
		(home-page "https://starship.rs")
		(license license:isc)
	)
)

starship
