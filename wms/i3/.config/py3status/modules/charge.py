import re

class Py3status:
	command = "acpi -b"
	format = "{icon} {value}"
	icon_steps = ["", "", "", "", "", "", "", "", "", ""]
	icon_charging = ""
	icon_missing = ""
	refresh = 2
	max_retries = 10

	def charge(self):
		status = self.py3.command_output(f"{self.command}").lower()

		level_match = re.search(r"[0-9]+(?=%)", status)
		mode_match = re.search(r"((dis)?charging|full)", status)

		if not level_match or not mode_match:
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

		level = int(level_match.group())
		mode = mode_match.group()

		if "discharging" in mode:
			icon_number = int(round(level * (len(self.icon_steps)-1) / 100))
			icon = self.icon_steps[icon_number]
		else:
			icon = self.icon_charging

		return {
			"full_text": self.py3.safe_format(self.format, {"icon": icon, "value": f"{level}%"}),
			"cached_until": self.py3.time_in(self.refresh)
		}
