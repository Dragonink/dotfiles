(define-module (devel manifest)
	#:autoload (gnu packages rust-apps) (
		hexyl
		git-interactive-rebase-tool
	)
	#:use-module (guix profiles)
	#:export (
		devel-manifest
	)
)

(define devel-manifest
	(packages->manifest (list
		hexyl
		git-interactive-rebase-tool
	))
)

devel-manifest
