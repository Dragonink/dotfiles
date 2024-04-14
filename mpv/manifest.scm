(define-module (mpv manifest)
	#:autoload (gnu packages video) (
		mpv
		mpv-mpris
	)
	#:use-module (guix profiles)
	#:export (
		mpv-manifest
	)
)

(define mpv-manifest
	(packages->manifest (list
		mpv
		mpv-mpris
	))
)

mpv-manifest
