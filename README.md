# bashrc

## Installation
First, install the requirements:
```bash
sudo apt install fonts-powerline gawk mlocate
```

Next you'll probably have to change the font of the terminal to something that supports powerline, in my case *DejaVu Sans Mono*.

If you want *cmdotd* working too, you'll have to get the python file from my [cmdotd repo](https://github.com/alek3y/cmdotd). \
In order to run it, bashrc uses `locate` to find the file. If you just downloaded the script you'll have to update the database, otherwise `locate` won't find that file:
```bash
sudo updatedb
```

# i3wm
<img src="https://i.ibb.co/BtzrS1z/linchad.png" /> \
Before trying to use i3 without knowing how it works and looks I suggest you to take a look at [this really useful guide](https://www.youtube.com/playlist?list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf).

## Installation
To make it work correctly you'll need to install these requirements:
```bash
sudo apt install i3 rofi compton i3blocks dunst i3lock libxcb-composite0 fonts-noto-color-emoji xautolock lm-sensors acpi lxappearance pavucontrol gawk bc xbacklight policykit-1-gnome
```

Now logout and select *i3* from the login screen. \
If you don't have a graphical login screen you'll have to search how to install one, that's why I suggest you to get a distro like Xubuntu with one preloaded.

Open a terminal with `MOD+Return` and follow this commands to copy the files of this repo inside your home directory (doing this will replace the files with the same name):
```bash
git clone https://github.com/alek3y/dotfiles
cp dotfiles/.* ~
```

Now, if you want, you can delete the `dotfiles` folder:
```bash
rm -rf dotfiles
```

*i3lock* is pretty bad, so I replaced it with [*i3lock-color*](https://github.com/Raymo111/i3lock-color). \
If you want a working lockscreen with these dotfiles you'll have to replace it too so, grab the latest release binary from [here](https://github.com/Raymo111/i3lock-color/releases) and replace the original with the downloaded file (this will delete the original, so you should either backup or reinstall it if you have problems):
```bash
path="$(which i3lock)"
sudo mv i3lock $path
sudo chown root:root $path
sudo chmod +x $path
```

## Appearance
To customize the appearance of the system you can use `lxappearance`, but before changing it you'll have to install a theme. \
My configuration files match the *Mint-Y-Dark-Red* theme from Linux Mint.

Grab the latest version for *mint-y-icons*, *mint-x-icons*, *mint-themes* from [here](http://packages.linuxmint.com/pool/main/m/) and inside the folder containing them run this command:
```bash
sudo dpkg -i mint-themes*.deb mint-x-icons*.deb mint-y-icons*.deb
```

If you get errors from `dpkg`, try to run this command:
```bash
sudo apt install -f
```

Now you can open `lxappearance` and, following my personal preference:
- Change font to *DejaVu Sans Regular* or *Book* and set the size to *10*
- Select *Mint-Y-Dark-Red* on the left menu
- Change icon theme to match the main theme
- Click apply

If you terminal doesn't display the triangles of the PS1, change its font to something else like *DejaVu Sans Mono*.

## Configuration
i3 is configured to work on **my** system, so you'll have to change some lines to make it working correctly. \
For a more in depth look you should read the [i3 Documentation](https://i3wm.org/docs/userguide.html).

Either way, you'll probably want to change the wallpaper path for i3 and i3lock, the workspace configuration and the display layout using `xrandr` (I suggest you to read the manual for that too so you won't face any problem with workspaces and display layout)

Here's the list of where you can find the configuration files:
- i3: `~/.config/i3/config`
- i3lock-color: `~/.config/i3/lockscreen.sh`
- rofi: `~/.config/rofi/theme.rasi`
- compton: `~/.config/compton.conf`
- i3blocks: `~/.config/i3blocks/config`
- dunst: `~/.config/dunst.conf`

If you want to customize them you really should read their manual. \
After reading it you can use [this website](https://thomashunter.name/i3-configurator/) to understand and customize i3's colors.

## Troubleshooting

### Resolution is too high
For me [setting the dpi](https://unix.stackexchange.com/a/413238/386339) of my 13-inch 3:2 UHD display to *130* worked well enough.

### Screen tearing
If you're facing this issue you should read compton's manual and edit its config file.

### Screen blanking not working
Check out [this guide](https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling) and edit the i3 config file accordingly.

### Brightness not working on i3bar
If you're using the backlight script for the i3bar, you'll have to follow [this guide](https://askubuntu.com/a/715310) to make `xbacklight` work correctly. \
Otherwise you could try `xrandr`, which is a software solution, using the `~/.config/i3blocks/brightness.sh` script. Unfortunately though, software like *Redshift* will reset the brightness.
For more help, follow [this guide](https://wiki.archlinux.org/index.php/Backlight).

### Battery not working on i3bar
If you can't see it, and assuming you know desktop computers don't have a battery, you'll have to check `~/.config/i3blocks/battery.sh` to find what's going on.

If instead you see the charging icon when it's not charging, try to remove the second condition that considers the "unknown" status as charging.

### Volume is not visible on i3bar
In that case you should check what audio server you're using and change the `MIXER` value inside `~/.config/i3blocks/volume.sh`. \
Or check what is the name of your control device with `amixer`, following its manual page.

### Not locking on lid close and suspend
To fix this you just have to create a new service to start *i3lock* on suspend. \
Create a file with these contents on `/etc/systemd/system/lockonsuspend.service` and replace `ale` with your username:
```
[Unit]
Description=Lock screen on suspend
Before=sleep.target

[Service]
Type=forking
User=ale
Group=ale
Environment=XAUTHORITY=/home/ale/.Xauthority
Environment=DISPLAY=:0
ExecStart=/home/ale/.config/i3/lockscreen.sh
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
```

Now, to apply, just run:
```bash
sudo systemctl enable lockonsuspend
```

### Temperature not working or visible on i3bar
Unfortunately, the method to filter the temperature is not universal, as in my case `thermal_zone0` is not the CPU. There are several ways to fix it though.

First of all, run this command to make sure the sensors are updated and check if with this it works:
```bash
sudo sensors-detect --auto
```

If it doesn't and you're lucky enough you can edit `~/.config/i3blocks/temperature.sh` and get it working by changing just one line. \
In my case the line that I care about from the command `sensors` is:
```
Tdie:         +49.0°C  (high = +70.0°C)
```
Knowing this I can extract it using 'tdie' as a filter. On the script change that string on `grep` with the name you care about and hope it'll works, otherwise you'll have to debug everything.

### I don't like your setup
I can't blame you, lol. \
I made one myself just because I couldn't find any configuration that was worth trying, so I tried to make one as minimal as possible without using a tons of dependencies. \
If you can't find a good configuration, you can always make one yourself. I actually suggest you to try.
