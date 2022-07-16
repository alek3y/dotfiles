class Py3status:
	command = "pamixer"
	format = "{icon} {value}"
	icon_steps = ["奔", "墳"]
	icon_missing = "奄"
	icon_muted = "婢"
	default = 20
	step = 5
	refresh = 0.5
	natural_scrolling = False
	max_retries = 10

	def audio(self):
		try:
			sink = self.py3.command_output(f"{self.command} --get-default-sink")
		except self.py3.CommandError:
			sink = None

		if not sink or "dummy" in sink.lower():
			retries = self.py3.storage_get("retries")

			updated_retries = 1
			if retries != None:
				updated_retries = retries + 1

			self.py3.storage_set("retries", updated_retries)
			stop_retrying = updated_retries > self.max_retries

			return {
				"full_text": self.py3.safe_format(self.format, {"icon": self.icon_missing, "value": "N/A"}),
				"cached_until": self.py3.CACHE_FOREVER if stop_retrying else self.py3.time_in(0.5)
			}

		volume = int(self.py3.command_output(f"{self.command} --get-volume"))
		is_muted = self.py3.command_output(f"{self.command} --get-mute")

		if "true" in is_muted:
			icon = self.icon_muted
		else:
			icon_number = int(round(volume * (len(self.icon_steps)-1) / 100))
			icon = self.icon_steps[icon_number]

		return {
			"full_text": self.py3.safe_format(self.format, {"icon": icon, "value": f"{volume}%"}),
			"cached_until": self.py3.time_in(self.refresh)
		}

	def on_click(self, event):
		button = event.get("button")

		if button == 1:
			self.py3.command_run(f"{self.command} -t")

		elif button == 2:
			self.py3.command_run(f"i3-msg exec pavucontrol")

		elif button == 3:
			self.py3.command_run(f"{self.command} --set-volume {self.default}")

		elif (button == 4 and not self.natural_scrolling) or (button == 5 and self.natural_scrolling):
			self.py3.command_run(f"{self.command} -i {self.step}")

		elif (button == 5 and not self.natural_scrolling) or (button == 4 and self.natural_scrolling):
			self.py3.command_run(f"{self.command} -d {self.step}")
