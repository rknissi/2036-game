extends Label3D

var label = Label3D.new()
label.text = "Hello, 3D World!"
label.position = Vector3(0, 2, 0)  # Adjust position in 3D space
add_child(label)
