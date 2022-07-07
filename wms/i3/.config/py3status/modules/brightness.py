class Py3status:
	command = "brightnessctl -c backlight -n1200"
	format = " {value}%"
	default = 20
	step = 5
	refresh = 0.3
	natural_scrolling = False

	def brightness(self):
		try:
			maximum = int(self.py3.command_output(f"{self.command} m"))
		except ValueError:
			return {
				"full_text": self.py3.safe_format(self.format, {"value": "N/A"}),
				"cached_until": self.py3.CACHE_FOREVER
			}

		current = int(self.py3.command_output(f"{self.command} g"))
		percentage = round(current * 100 / maximum)

		return {
			"full_text": self.py3.safe_format(self.format, {"value": percentage}),
			"cached_until": self.py3.time_in(self.refresh),
		}

	def on_click(self, event):
		button = event.get("button")

		amount = None
		if button == 1:
			amount = f"{self.default}%"
		elif (button == 4 and not self.natural_scrolling) or (button == 5 and self.natural_scrolling):
			amount = f"+{self.step}%"
		elif (button == 5 and not self.natural_scrolling) or (button == 4 and self.natural_scrolling):
			amount = f"{self.step}%-"

		if amount:
			self.py3.command_run(f"{self.command} s {amount}")
