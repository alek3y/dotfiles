#!/usr/bin/python3

import os, sys
import requests

OUTPUT = os.path.dirname(sys.argv[0])

REPO_URL = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/"
FONTS = {
	"patched-fonts/Noto/Sans-Mono/complete/Noto%20Sans%20Mono%20": {
		"Bold%20Nerd%20Font%20Complete.ttf": "NotoSansMono-Black-Nerd-Font-Complete.ttf",
		"Light%20Nerd%20Font%20Complete.ttf": "NotoSansMono-Light-Nerd-Font-Complete.ttf",
		"Medium%20Nerd%20Font%20Complete.ttf": "NotoSansMono-Medium-Nerd-Font-Complete.ttf",
		"Regular%20Nerd%20Font%20Complete.ttf": "NotoSansMono-Regular-Nerd-Font-Complete.ttf",
		"Thin%20Nerd%20Font%20Complete.ttf": "NotoSansMono-Thin-Nerd-Font-Complete.ttf"
	},
	"patched-fonts/SourceCodePro/": {
		"Light/complete/Sauce%20Code%20Pro%20Light%20Nerd%20Font%20Complete.ttf": "SauceCodePro-Light-Nerd-Font-Complete.ttf",
		"Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf": "SauceCodePro-Nerd-Font-Complete.ttf",
		"Extra-Light/complete/Sauce%20Code%20Pro%20ExtraLight%20Nerd%20Font%20Complete.ttf": "SauceCodePro-ExtraLight-Nerd-Font-Complete.ttf",
		"Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete.ttf": "SauceCodePro-Semibold-Nerd-Font-Complete.ttf",
		"Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf": "SauceCodePro-Bold-Nerd-Font-Complete.ttf",
		"Black/complete/Sauce%20Code%20Pro%20Black%20Nerd%20Font%20Complete.ttf": "SauceCodePro-Black-Nerd-Font-Complete.ttf",
		"Medium/complete/Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf": "SauceCodePro-Medium-Nerd-Font-Complete.ttf"
	}
}
LICENSE = "LICENSE"

for font in FONTS:
	for ttf in FONTS[font]:
		output_ttf = FONTS[font][ttf]
		print(f"Downloading {output_ttf}...")
		repo_ttf = requests.get(REPO_URL + font + ttf)
		open(OUTPUT + "/" + output_ttf, "wb").write(repo_ttf.content)

open(OUTPUT + "/LICENSE", "wb").write(requests.get(REPO_URL + LICENSE).content)
