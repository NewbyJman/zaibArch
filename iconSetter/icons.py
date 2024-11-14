import os, glob, sys, codecs, cairosvg

working_path = "/home/zaib/Downloads/Papirus"
oldColour="#ffffff"
newColour="#7e57c2"
svgFolders = ["devices", "status", "actions", "places", "apps", "categories", "emblems", "mimetypes", "panel"]
fileManagers = ["system-file-manager.svg", "dde-file-manager.svg", "org.xfce.filemanager.svg", "xfce-filemanager.svg"]
fileManagerIco = ["system-file-manager-panel.svg", "system-file-manager-symbolic.svg", "file-manager.svg"]

def fileManager():
	for folder in os.listdir(working_path):
		cdir = f"{working_path}/{folder}"
		if os.path.isdir(cdir):
			for subFolder in os.listdir(cdir):
				newPath = f"{cdir}/{subFolder}"
				print(newPath)
				for file in os.listdir(f"{newPath}"):
					cfile = f"{cdir}/{subFolder}/{file}"
					if file in fileManagers:
						print(cfile)
						os.system(f"cp -f /home/zaib/Downloads/folder.svg /home/zaib/Downloads/{file}")
						os.system(f"cp -f /home/zaib/Downloads/{file} {cfile}")
					elif file in fileManagerIco:
						print(cfile)
						os.system(f"cp -f /home/zaib/Downloads/folder2.svg /home/zaib/Downloads/{file}")
						os.system(f"cp -f /home/zaib/Downloads/{file} {cfile}")

def svgRecolor(svgFolder):
	for folder in os.listdir(working_path):
		cdir = f"{working_path}/{folder}"
		if os.path.isdir(cdir) and os.path.exists(f"{cdir}/{svgFolder}"):
			cdir = f"{cdir}/{svgFolder}"
			print(cdir)
			for file in os.listdir(cdir):
				cfile = f"{cdir}/{file}"
				with codecs.open(cfile, encoding='utf-8', errors='ignore') as f:
					color = f.read()
				if f"ColorScheme-Text {{ color:{oldColour}; }}" in color:
					newColor = color.replace(f"color:{oldColour}", f"color:{newColour}")
					cairosvg.svg2svg(bytestring=newColor, write_to=cfile)
				elif f'path style="fill:{oldColour}"' in color:
					newColor = color.replace(f"fill:{oldColour}", f"fill:{newColour}")
					cairosvg.svg2svg(bytestring=newColor, write_to=cfile)


def delFolderColours():
	folder_colors = ["adwaita", "black", "blue", "bluegrey", "breeze", "brown", "carmine", "cyan", "darkcyan", "deeporange", "green", "grey", "indigo", "magenta", "nordic", "orange", "palebrown", "paleorange", "pink", "red", "teal", "white", "yellow", "yaru"]
	for folder in os.listdir(working_path):
		cdir = f"{working_path}/{folder}"
		if os.path.isdir(cdir) and os.path.exists(f"{cdir}/places"):
			cdir = f"{cdir}/places"
			for file in os.listdir(cdir):
				for color in folder_colors:
					if file.startswith(f"folder-{color}-") or file.startswith(f"user-{color}-") or file==f"folder-{color}.svg" and not file==f"folder-red.svg":
						print(f"deleting: {color}")
						os.remove(f"{cdir}/{file}")

fileManager()
#for svgFolder in svgFolders:
#	svgRecolor(svgFolder)
#delFolderColours()



def svgChecker(filepath):
	with codecs.open(filepath, encoding='utf-8', errors='ignore') as f:
		color = f.read()
	print(color)

#svgChecker("/home/zaib/Downloads/Papirus-Dark/symbolic/mimetypes/x-office-address-book-symbolic.svg")













