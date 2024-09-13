# No-op if the terminal is not kitty
if ($env.KITTY_INSTALLATION_DIR? != null) {
	$env.config = (
		$env.config
		| upsert use_kitty_protocol true
		| upsert ls.clickable_links true
		| upsert shell_integration {
			osc2: true,
			osc7: true,
			osc8: true,
			osc9_9: false,
			osc133: true,
			osc633: true,
			reset_application_mode: true,
		}
	)
}
