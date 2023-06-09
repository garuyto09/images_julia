#####################
# Alunos: Gabriel Henriquse Cerqueira e Stella Riko Uchidomari Nakamura
# RA: 197356 e 193953
# Professor: Marcos do Valle
#####################

#####################
# PARTE 0 - Inicializar Pacotes
#####################

using Images, CoordinateTransformations, Rotations, Colors, ImageView, ImageTransformations, PaddedViews, ImageCore

#####################
# PARTE 1 - Carregar Imagens
#####################
img = load("C:/Users/garuy/Desktop/Coisas Gabriel/Imgs/exemplos/valle.jpg")
cv = channelview(img)

#####################
# PARTE 2 - Separar as Cores
#####################

R = StackedView(cv[1,:,:], zeroarray, zeroarray)
G = StackedView(zeroarray, cv[2,:,:], zeroarray)
B = StackedView(zeroarray, zeroarray, cv[3,:,:])

red = colorview(RGB, R)
green = colorview(RGB, G)
blue = colorview(RGB, B)

#####################
# PARTE 3 - Rotacionar o B e o G
#####################

trfm = recenter(RotMatrix(pi/100), center(blue))
imgw = warp(blue, trfm)
novo_blue = imresize(imgw, size(red))

trfm2 = recenter(RotMatrix(-pi/100), center(green))
imgw2 = warp(green, trfm)
novo_green = imresize(imgw2, size(red))

#####################
# PARTE 4 - Gerar Imagem com Aberração 1
#####################

original = red + novo_green  + novo_blue

save("C:/Users/garuy/Desktop/Coisas Gabriel/Imgs/exemplos/valle_croma1.png", original)

#####################
# PARTE 5 - Pegar dimensões da Figura
#####################

X, Y = size(red)
por_1 = 0.99
por_2 = 0.98
por_3 = 0.97
por_4 = 0.96

#####################
# PARTE 6 - Gerar Imagem com Aberração 2
#####################

green_diferente = imresize(green, (Integer(round(X*por_1)),Integer(round(Y*por_2)))) 
blue_diferente = imresize(blue, (Integer(round(X*por_3)),Integer(round(Y*por_4))))
original_2 = red + PaddedView(0, green_diferente,(size(red))) + PaddedView(0, blue_diferente, (size(red)))
save("C:/Users/garuy/Desktop/Coisas Gabriel/Imgs/exemplos/valle_croma2.png", original_2)
