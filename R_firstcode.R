## Realizzazione del primo codice in Git Hub

# Installazione dei pacchetti necessari 
install.packages("raster")
library(raster)

# Settaggio cartella di lavoro (togliendo o mettendo # scelgo il mio sistema operativo) 
setwd("~/lab/") # Linux
# setwd("/Users/emma/desktop/lab") #mac
# setwd("C:/lab/") # windows

# importo l'immagino con il comando brick 
l2011 <- brick("p224r63_2011.grd")
l2011

# plotto l'immagine appena caricata 
plot(l2011)

#plotto l'immagine con una scala di colori scelta 
# https://www.r-graph-gallery.com/42-colors-names.html
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011, col=cl)

# dev.off() per chiudere la finestra che mostra l'immagine 

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot della banda del blu - B1_sre
plot(l2011$B1_sre) # trinity
# or
plot(l2011[[1]]) # neo

plot(l2011$B1_sre)
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl)

# plot b1 from dark blue to blue to light blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

# Esportiamo l'immagine come pdf 
pdf("banda1.pdf") #il comando esporta il pdf direttamente nella cartella di lavoro da noi settata 
plot(l2011$B1_sre, col=clb)
dev.off()

png("banda1.png") #esportiamo l'immagine in formato png 
plot(l2011$B1_sre, col=clb)
dev.off()

# plot b2 from dark green to green to light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

# come fare un multiframe
par(mfrow=c(1,2)) #permette di avere più plot nella stessa pagina
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

#esportiamo il multiframe 
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# esercizio: inverti il multiframe
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# Plottiamo le prime quattro bande 
par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb)
# green
plot(l2011$B2_sre, col=clg)
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# Plot di l2011  (NIR band)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100) #specifichiamo sempre la scala di colore 
plot(l2011$B4_sre, col=clnir)
# oppure posso usare anche il metodo seguente 
plot(l2011[[4]])

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot RGB layers
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Esercizio:crea un multiframe con il visibile RGB
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Esercizio: carica l'immagine del 1988
l1988 <- brick("p224r63_1988_masked.grd")
l1988

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

#Ecercise: plot la banda NIR 
plot(l2011[[4]])

#rendiamo l'immagine con i colori del visibile (come se la vedessimo con i nostri occhi)
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") 

#mettiamo il vicino infrarosso sulla componente r (tutto quello che riflette la vegetazione sarà quindi rosso)
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") 

#spostiamo l'infrarosso sulla componente g
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") 

#spostiamo l'infrarosso sulla componente blu 
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") 

#esercizio: importare l'immagine del 1988
plotRGB(l1988, r=3, g=2, b=1, stretch="lin")
plotRGB(l1988, r=4, g=3, b=1, stretch="lin")
plotRGB(l1988, 4,3,2, strech="lin") #metodo più speditivo di scrittura 

#creazione di un multiframe 
par(mfrow=c(2,1))
plotRGB(l1988, 4,3,2, stretch="lin")
plotRGB(l2011, 4,3,2, stretch="Lin") 
dev.off()

#eseguiamo uno strech per istogrammi e non lineare 
plotRGB(l1988, 4,3,2, stretch="Hist")

#esercizio: esegui un par (2,2) con plotRGB (due hist e due lin) con r=4
par(mfrow=c(2,2))
plotRGB(l1988, 4,3,2, stretch="lin")
plotRGB(l2011, 4,3,2, stretch="lin")
plotRGB(l1988, 4,3,2, stretch="hist")
plotRGB(l2011, 4,3,2, stretch="hist")
