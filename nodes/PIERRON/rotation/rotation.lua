moteur = require("stepper")

moteur.init({3,1,2,4})

moteur.rotate(moteur.REVERSE, 360/3.3/2, 20, function() print("Fin!")end)

moteur.rotate(moteur.FORWARD,nil,25)

moteur.stop()
