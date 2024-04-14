(add-to-load-path (dirname (current-filename)))

(use-modules
	(gnu packages admin)
	(gnu packages base)
	(gnu packages fontutils)
	(gnu packages imagemagick)
	(gnu packages less)
	(gnu packages man)
	(gnu packages package-management)
	(gnu packages rust-apps)
	(gnu packages shellutils)
	(gnu packages terminals)
	(gnu packages texinfo)
	(gnu packages w3m)
	(guix build-system copy)
	(guix gexp)
	(guix git-download)
	((guix licenses) #:prefix license:)
	(guix packages)

	(bashmount guix)
	(fonts manifest)
	(mpv manifest)
	(starship guix)
)

(define my-glibc-locales
	(make-glibc-utf8-locales glibc
		#:name "my-glibc-locales"
		#:locales '("en_US" "fr_FR")
	)
)

(define forgit
	(package
		(name "forgit")
		(version "24.04.0")
		(source (origin
			(method git-fetch)
			(uri (git-reference
				(url "https://github.com/wfxr/forgit.git")
				(commit version)
			))
			(file-name (git-file-name name version))
			(hash (content-hash "1vp7slxzsyj026d0xj39xkjszq2zahac38h7gjmyzfvpccvnby3y"))
		))

		(build-system copy-build-system)
		(propagated-inputs (list
			fzf
		))
		(arguments (list
			#:install-plan #~'(
				("bin/git-forgit" "bin/")
				("completions/git-forgit.bash" "share/bash-completion/completions/")
				("completions/_git-forgit" "share/zsh/site-functions/")
				("forgit.plugin.zsh" #$(string-append "share/zsh/plugins/" name "/"))
				("completions/git-forgit.fish" "share/fish/completions/")
				("conf.d/forgit.plugin.fish" "share/fish/vendor_conf.d/")
			)
			#:phases #~(modify-phases %standard-phases
				(add-after 'install 'symlink-bins
					(lambda* (#:key outputs #:allow-other-keys)
						(let*
							(
								(out (assoc-ref outputs "out"))
								(exe (string-append out "/bin/git-forgit"))
								(zsh-bin (string-append out "/share/zsh/plugins/" #$name "/bin/"))
								(fish-bin (string-append out "/share/fish/vendor_conf.d/bin/"))
							)
							(mkdir-p zsh-bin)
							(symlink exe (string-append zsh-bin "git-forgit"))
							(mkdir-p fish-bin)
							(symlink exe (string-append fish-bin "git-forgit"))
						)
					)
				)
			)
		))

		(synopsis "A utility tool powered by @command{fzf} for using @command{git} interactively")
		(description synopsis)
		(home-page "https://github.com/wfxr/forgit")
		(license license:expat)
	)
)

(concatenate-manifests (list
	(packages->manifest (list
		stow

		bashmount-with-udisks
		bat
		btop
		eza
		forgit
		fzf
		imagemagick
		lesspipe
		nnn
		starship
		trash-cli
		w3m

		my-glibc-locales
		man-db
		info-reader
	))
	fonts-manifest
	mpv-manifest
))
