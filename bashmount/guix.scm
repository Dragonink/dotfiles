(define-module (bashmount guix)
	#:autoload (gnu packages base) (sed)
	#:autoload (gnu packages bash) (bash)
	#:autoload (gnu packages compression) (gzip)
	#:autoload (gnu packages freedesktop) (udisks)
	#:autoload (gnu packages linux) (util-linux)
	#:autoload (gnu packages ncurses) (ncurses)
	#:use-module (guix build-system copy)
	#:use-module (guix gexp)
	#:use-module (guix git-download)
	#:use-module ((guix licenses) #:prefix license:)
	#:use-module (guix packages)
	#:use-module (guix utils)
	#:export (
		bashmount
		bashmount-with-udisks
	)
)

(define bashmount
	(package
		(name "bashmount")
		(version "4.3.2")
		(source (origin
			(method git-fetch)
			(uri (git-reference
				(url "https://github.com/jamielinux/bashmount.git")
				(commit version)
			))
			(file-name (git-file-name name version))
			(hash (content-hash "1irw47s6i1qwxd20cymzlfw5sv579cw877l27j3p66qfhgadwxrl"))
		))

		(build-system copy-build-system)
		(arguments (list
			#:install-plan #~'(
				("bashmount" "bin/")
				("bashmount.1.gz" "share/man/man1/")
				("bashmount.conf" "share/bashmount/config")
			)
			#:phases #~(modify-phases %standard-phases
				(add-before 'install 'compress-man-page
					(lambda* (#:key #:allow-other-keys)
						(invoke "gzip" "-9" "bashmount.1")
					)
				)
			)
		))
		(native-inputs (list
			gzip
		))
		(propagated-inputs (list
			bash
			util-linux
			ncurses
			sed
		))

		(synopsis "Tool to mount and unmount removable media from the command-line")
		(description synopsis)
		(home-page "https://github.com/jamielinux/bashmount")
		(license license:gpl2)
	)
)

(define bashmount-with-udisks
	(package
		(inherit bashmount)

		(propagated-inputs (modify-inputs (package-propagated-inputs bashmount)
			(append udisks)
		))
		(arguments (substitute-keyword-arguments (package-arguments bashmount)
			(
				(#:phases phases)
				#~(modify-phases #$phases
					(add-after 'install 'enable-udisks
						(lambda* (#:key outputs #:allow-other-keys)
							(let
								(
									(out (assoc-ref outputs "out"))
								)
								(substitute* (string-append out "/share/bashmount/config")
									(
										("^#?udisks=.*$")
										"udisks=1\n"
									)
								)
							)
						)
					)
				)
			)
		))
	)
)

bashmount-with-udisks
