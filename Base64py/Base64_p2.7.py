#! python2

from Tkinter import *
from base64 import *
from subprocess import *

# Build TK Main Window
root = Tk()
root.title('Base64 converter')
root.resizable(width=False, height=False)
x = (root.winfo_screenwidth() - root.winfo_reqwidth()) / 2
y = (root.winfo_screenheight() - root.winfo_reqheight()) / 3
root.geometry("+{}+{}".format(x, y))

# initial Variable for Entry Field
t = StringVar()


def encode():  # Encode Entry Field
    t.set(b64encode(t.get()))


def decode():  # Decode Entry Field
    t.set(b64decode(t.get()))

# Label
Lbl = Label(root, text="enter value below")
Lbl.grid(sticky=S)

# Entry Field
e = Entry(root, textvariable=t, width=30)
e.grid(row=1, sticky=W)

# Buttons - Encode
BtnE = Button(root, text="encode", command=encode)
BtnE.grid(row=2, sticky=W)

# Buttons - Decode
BtnD = Button(root, text="decode", command=decode)
BtnD.grid(row=2, sticky=S)

# Buttons - Exit
BtnEx = Button(root, text="quit", command=root.quit)
BtnEx.grid(row=2, sticky=E)

# Keep Mainloop running / TK Window Open
root.call('wm', 'attributes', '.', '-topmost', True)
root.mainloop()
