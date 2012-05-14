====================================================
Sources Cohérentes, Battements, Sources Incohérentes
====================================================

Cette séance de travaux pratiques avait pour objectif l'étude de l'addition de sources sonores (en fonction de leurs fréquences et phases respectives) ainsi que celle des effets perceptifs qui y sont liés.

Pour ce faire, nous procéderons en deux parties.

Nous nous intéresseront premièrement aux sources cohérentes, avec quelques démonstrations théoriques ainsi que deux manipulations.

La seconde partie portera sur les phénomènes de battements et les sources incohérentes.
Nous traiterons d'abord de théorie, puis passerons à l'expérimentation.

Ce TP sera aussi marqué par quelques références à des applications et des tracés via Octave.

Sources Cohérentes
==================

L'objectif est d'étudier l'influence du déphasage sur le signal résultant de l'addition de deux sources.

Théorie
-------

input{formule_1.tex}

Expérience
----------

Analyse subjective
~~~~~~~~~~~~~~~~~~

Après avoir relié les appareils comme demandé, nous réalisons la série suivante :

+--------------+------------------------+
|   Fréquence  | Déphasage pour un min. |
+--------------+------------------------+
|    100 Hz    |        pi +2kpi        |
|    200 Hz    |        pi +2kpi        |
|    800 Hz    |        pi +2kpi        |
|   1600 Hz    |        pi +2kpi        |
+--------------+------------------------+

On note que c'est en adéquation avec les calculs.

Nous observons aussi des maxima pour 0.
Là encore, c'est en adéquation avec la théorie.

Les maxima et minima se "sentent" bien à l'oreille.

Utilisation d'un microphone
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Après avoir fixé les amplitudes des deux signaux à l'oscilloscope, nous mesurons.

Pour une source seule, nous avons :

Vrms = 35 mV

Cette valeur nous servira de référence dans le calcul des gains.

Pour deux sources en phase :

Vrms = 45mV

Ce qui nous donne un gain de G = 20log(45/35) = 2.18dB

Pour deux sources en quadrature de phase :

Vrms = 40 mV

Ce qui nous donne un gain de G = 20log(40/35) = 1.15dB

Pour deux sources en opposition de phase :

Vrms = 14mV

Ce qui nous donne un gain de G = 20log(14/35) = -7.95dB

On peut résumer le tout ainsi :

+--------------------+-----------------------+----------------------+
|      Déphasage     |     Gain Théorique    |  Gain expérimental   |
+--------------------+-----------------------+----------------------+
|        0           |         +6dB          |       +2.18dB        |
|       pi/2         |         +3dB          |       +1.15dB        |
|        pi          |         -infty        |       -7.95dB        |
+--------------------+-----------------------+----------------------+

Même si l'adéquation n'est pas parfaite, on remarque que le rapport entre les gains pour phi=0 et phi=pi/2 est quasiment conservé et que celui pour phi=pi est largement en deçà des deux autres.

Les causes possibles d'inadéquation entre pratique et théorie peuvent être :

- mauvaise qualité de l'ampli, des haut-parleurs
- mauvaise précision dans le règlage
- caractère non-idéal de la chaine d'excitation
- mauvais positionnement des sources, de la prise de mesure
- phénomènes liés à l'environnement (réverbération, etc...)


Applications
~~~~~~~~~~~~

Pour ce qui est de la conduite, on peut envisager de place un micro dans la conduite.
Le signal capté est ensuite déphasé de pi et renvoyé vers un haut parleur situé dans cette même conduite, après le micro.

L'amélioration suivante pourrait être d'utiliser un système d'asservissement et un second micro en sortie de conduite afin de mieux contrôler les effets.

Le bouton PHASE applique un déphasage de pi au signal pour que celui ci revienne correctement.
Si on applique ce même déphasage deux fois, on obtiendra un déphasage résultant de 0 ce qui produira l'effet inverse : un amplification du signal.

Battements - Sources Incohérentes
=================================

Avant
-----

La somme est un sinus dont l'amplitude varie de -2A à 2A (avec A l'amplitude de l'excitation initiale).

D'après l'affichage sur l'oscilloscope, on peut prévoir d'entendre une sorte "d'ondulation en amplitude".

Au cours de la rédaction du compte rendu, nous avons tracé le phénomène avec Octave, ce tracé est disponible en annexe 1.

La visualisation du profil de pression à l'oscilloscope (via un microphone) est en adéquation avec ce que nous avions modélisé précédement.
Les légères différences perceptibles sont probablement dûes au caractère non idéal (et loin de là) de l'environnement (réverbération, bruit de fond non négligeable, etc...).


Impressions
-----------

On ressent une "ondulation" toutes les secondes environ.

Nos deux fréquences utilisées sont 100Hz et 101Hz (cf. modélisation en annexe 1).

L'oscilloscope indique sensiblement la même chose : une fréquence de battement de 1Hz.

Afin de comprendre (ou du moins d'essayer) l'influence du Delta f sur le phénomène de battement, nous avons aussi essayé de tracer les courbes résultantes pour plusieurs Delta f. Ces courbes sont disponibles en annexe 3. 

On remarque que lorsque Delta f devient grand (approx 50Hz) le signal résultant se comporte comme l'addition de 2 sources incohérentes.
Pour des Delta f moyens (entre 5 et 40Hz environ), l'interférence entre les sources est importante et à l'oreille, le battement est très présent.
Pour des Delta f petits (moins de 5Hz), le signal résultant est affecté, mais cela n'est pas particulièrement dérangeant à l'oreille.

La fréquence des battements augmente progressivement puis ceux ci disparaissent.

Mesures Quantitatives
---------------------

A l'oreille, on compte environ 1 battement par seconde, or,

Delta f = f_1 - f_2 = 1 Hz

En augmentant progressivement f_2, on finit par ne plus entendre le phénomène. La fréquence limite est de 150Hz (ce que nous avions remarqué en annexe 3).

Pour différents f_1 (200Hz, 400Hz, 1kHz et 2kHz), on remarque que la fréquence limite est souvent telle que f_lim = f_1 + 50Hz .

Si les fréquences sont multiples, alors on observe un signal de la plus grande des deux fréquence modulé en offset par le signal de la plus faible fréquence.

Application
-----------

L'accord d'un instrument peut se faire en tirant parti de ce phénomène.

On joue par exemple une note sur la corde à accorder en même temps qu'une note "étalon" dont on sait qu'elle est juste.
On accorde alors en cherchant à diminuer la fréquence des battements. Lorsque l'on parvient à les annuler, on a atteint un multiple de la fréquence étalon, ensuite, il faut faire confiance à son oreille pour être sûr de ne pas s'être trompé d'octave...


On observe deux type d'interférence dûes au déphasage, les interférences contructives lorsque les haut-parleurs sont déphasés de 2kpi et les interférences destructives lorsqu'ils sont déphasés de (2k-1)pi. Entre les deux on observe un phase de transition.
On observe également un phénomène de battement lorsque deux sources émettent avec des fréquence proches.
De plus, les phénomènes étudiés ici ont été mis en relation avec des cas concrets, ce qui nous permit de mieux en saisir l'utilité.
