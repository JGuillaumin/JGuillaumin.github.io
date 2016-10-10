---
layout: post
title: Deep Learning Workshop at PyCon France - Otober 15, 2016
subtitle: Information about the workshop
bigimg: /img/post/deeplearning-bigimg.png
tags: [deep-learning, workshop, pycon, tutorial]
---


Vous trouverez ici les informations concernant <a href="https://2016.pycon.fr/pages/programme.html#Introduction%20au%20Deep%20Learning%20avec%20theano">l'atelier</a> que j'anime le 15 octobre 2016 à la PyCon France, sur le campus de Télécom Bretagne à Rennes.

Il s'agira d'une introduction au Deep Learning avec la librairie <a href="http://deeplearning.net/software/theano/">theano</a>.

Voici la description de l'atlier :

>C’est indéniable, le Deep Learning c’est le sujet à la mode ! Même si cela reste un domaine de recherche très pointu heureusement à l’aide de nombreux frameworks open source et formations sur Internet les concepts deviennent de plus en plus accessibles. Cet atelier propose un tour d’horizon sur les origines du Deep Learning, quelles sont les ruptures scientifiques des 10 dernières années qui l’ont rendu aussi populaire, quelles sont les dernières architectures à la mode. Tout au long de l'atelier vous allez pouvoir coder vos propres architectures profondes avec theano ! Cette librairie Python est parfaite pour le Deep Learning ! Elle est même très utilisée en recherche, pour prototyper rapidement de nouveaux modèles. L'objectif de l'atelier est de donner les bases théoriques et pratiques (via theano) du Deep Learning.


L'atelier se déroulera sur des notebooks Jupyter. 
Toutes les ressources seront disponibles le jour de l'atelier sur des clefs USB. 



# Instructions pour l'atelier 

L'atelier se déroulera sur des notebooks Jupyter, sous python 2.7 . 
Vous pouvez installer sur votre machine les librairies une à une, ou bien utiliser une image Docker contenant toutes les dépendances. 

## Comme un grand j'installe toutes les librairies 

* Pour Linux et Windows (je n'ai testé que pour Ubuntu 14 et 16)

Voici la liste des commandes pour installer toutes les librairies nécessaires: 

```
sudo apt-get update && apt-get install -y git wget libopenblas-dev python-dev python-pip python-nose python-numpy python-scipy python-matplotlib ipython ipython-notebook graphviz
pip install --upgrade --no-deps git+git://github.com/theano/theano.git
pip install jupyter
pip install pydot
pip install graphviz

```
Vous avez beaucoup de ces librairies sur vos machines normalement. 
A vous de faire le tri. 

Mais pour information : 

* graphviz (via apt-get) + pydot (via pip) + graphviz (via pip) : Surtout faire dans cet ordre. Ces librairies seront utiles pour visualiser les expressions mathématiques dans theano sous forme de graphes.

* numpy, libopenblas-dev, python-nose : sont les librairies nécessaires pour installer theano.


Si vous suivez ces informations, vous allez pouvoir faire l'intégralité de l'atelier sur votre machine en utilisant le CPU.

Nous verrons ensemble que theano génère du code automatiquement pour CPU ou GPU (si ce dernier est présent et activé) !

Pour utiliser votre carte graphique (uniquement Nvidia) je vous invite à suivre les instruction sur <a href="http://deeplearning.net/software/theano/install_ubuntu.html#install-ubuntu">cette page</a>.
Il vous faudra avoir des drivers graphiques à jour !

**Mais sachez que l'installation des drivers Nvidia, de CUDA et ses dépendances sont compliquées, surtout sur les ordinateurs portables avec la technologie _Optimus_ de Nvidia**

**Pour notre atelier, les données et modèles étant relativement simples, installer rapidement theano, pour faire tourner les calculs uniquement sur CPU ira très bien !!**

Donc si vous êtes : 

- sans carte graphique, peu motivé à vous battre pour installer theano sur le GPU
- sans expérience sur Docker (section suivante) 

Je vous conseille de suivre les instructions du début pour installer theano rapidement !



## Vous connaissez Docker ? 

Pour ceux qui connaissent Docker, j'ai préparé un `Dockerfile` avec toutes les dépendances et librairies nécessaires ! 
Elle fonctionne avec `docker` pour faire tourner les calculs uniquement sur le CPU, ou bien avec `nvidia-docker` pour s'aider d'une carte graphique (uniquement Nvidia).

L'installation est vraiment plus simple, Docker fait tout pour nous !


### Pour faire tourner sur le CPU avec `docker`

* Linux (ou Windows)


Créer un fichier nommé `Dockerfile` (sans extension) contenant : 


```
# Start with cuDNN base image
FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Julien Guillaumin <julien.guillaumin@telecom-bretagne.eu> 

# Install git, wget, python-dev, pip and other dependencies
RUN apt-get update && apt-get install -y \
  git \
  wget \
  libopenblas-dev \
  python-dev \
  python-pip \
  python-nose \
  python-numpy \
  python-scipy \
  python-matplotlib \
  ipython \
  ipython-notebook \
  graphviz

# Set CUDA_ROOT
ENV CUDA_ROOT /usr/local/cuda/bin

# Install bleeding-edge Theano
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
RUN pip install jupyter
RUN pip install pydot
RUN pip install graphviz

# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=gpu\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > /root/.theanorc


# Clean apt-get tempory files
RUN rm -rf /var/lib/apt/lists/*

```


Placez-vous dans le répertoire contenant ce fichier 

```
docker build -t jguillaumin/pycon-theano .
docker run -it -p 8888:8888 -v "$PWD"/PyCon_2016_Introduction_Deep_Learning/:/home/:rw jguillaumin/pycon-theano
```

Une fois l'image lancée : 

``` 
cd home/
jupyter notebook --ip 0.0.0.0 --no-browser &
```
Vous pourrez ensuite aller sur votre navigateur préféré et accéder à : `localhost:8888/tree`.

Vous n'avez pas encore le répértoire `PyCon_2016_Introduction_Deep_Learning`, essayez avec un autre pour l'instant.

Tout le contenu de l'atelier vous sera remis le jour J ! 



### Pour faire tourner sur le GPU avec `nvidia-docker`

* Uniquement machine Linux, avec drivers Nvidia (>= 352)

Vous devez avoir une carte graphique Nvidia récente (qui supporte CUDA 8.0), des drivers récents (>= 352.xx) et installer `nvidia-docker`. 
Cet outil permet de monter des images Docker ayant accès aux ressources de la carte de graphique ! 

Je vous invite à voir les recommandations <a href="https://github.com/NVIDIA/nvidia-docker/wiki/Installation">ici</a>, ainsi que l'installation. 

Ensuite il s'agit des mêmes commandes (on change `docker` par `nvidia-docker` pour lancer l'image): 

```
docker build -t jguillaumin/pycon-theano .
nvidia-docker run -it -p 8888:8888 -v "$PWD"/PyCon_2016_Introduction_Deep_Learning/:/home/:rw jguillaumin/pycon-theano
```


Une fois l'image lancée : 

``` 
cd home/
jupyter notebook --ip 0.0.0.0 --no-browser &
```





## Conclusion 

Voilà pour les instructions d'installation ! 
N'hésitez pas à m'envoyer <a href="julien.guillaumin@telecom-bretagne.eu">un mail</a> en cas de problème. 

Pensez à installer le nécessaire pour l'atelier, cela peut prendre du temps (1 Go pour les images Docker par exemple). 




