===========================
Notion de signal périodique
===========================
----------------------
Exemple du son musical
----------------------

Etude de la fréquence fondamentale
==================================

Nous réalisons le montage et jouons (un peu) avec le synthé (nous sommes musiciens... désolé).

Jeu de notes successives
------------------------

Pour une fenêtre temporelle large, on observe une augmentation rapide de l'amplitude du signal après la frappe (attaque), suivie d'une diminution lente.

Pour une fenêtre plus étroite, on note que le signal est sinusoïdal, légèrement bruité (probablement dû à l'amplificateur et à la piètre qualité du montage).
C'est dans cette vue que l'on peut déterminer la note elle-même.

Lors de l'attaque, le signal a tendance à s'écrêter (cela est probablement dû à l'ampli), ensuite, seule l'amplitude varie significativement.
Ce dernier point concorde avec la décroissance observée en fenêtre large.

Hautbois et flute
-----------------

Hautbois
~~~~~~~~

En observant la note jouée en entier (fenêtre large), on note une attaque très rapide.
La décroissance est variable selon le jeu du musicien (mais peut être très bref).
On remarque aussi que pendant la note, l'amplitude varie, de manière cyclique.

En observant le signal de plus près, on a l'impression d'observer une somme de deux sinusoïdes.
Nous imputons cela à la double anche de l'instrument (même si on est en droit de douter qu'un synthé ait une double anche, surtout celui là, ahem.).

Flute
~~~~~

On observe toujours une attaque rapide, une légère décroissance pour arriver à une période de mantien (dont la durée est laissé à la discretion du musicien), puis une décroissance rapide avant la fin de la note.

Pour ce qui est du signal en fenêtre plus étroite, on observe un (joli) sinus régulier.
Le contenu fréquentiel est assez faible.

Octaves
-------

On joue plusieurs notes et leur octave.

+--------+--------+--------+--------+
| Note 1 | Freq 1 | Octave | Freq   |
+--------+--------+--------+--------+
| LA 3   |  442Hz |  LA 4  | 882Hz  |
| SOL 2  |  197Hz |  SOL 3 | 395Hz  |
| FA 4   |  704Hz |  FA 5  | 1,4kHz |
+--------+--------+--------+--------+

On note que pour passer de la fréquence de la note à celle de son octave, il faut multiplier la première fréquence par 2.

Notes et fréquences
-------------------

On trace les points demandés (cf. annexe 1).
Contre toute attente (ahem.), cela forme une droite.

Le coefficient directeur de cette droite est égal à root12(2) (racine douxième de 2).

Etude du spectre
================

Les tracés sont disponibles en annexe 2.

La fréquence du signal obtenu est celle du signal de plus faible fréquence (plus grande période), soit *p1*, 1 unité.

Lorsque l'on fait tendre le nombre d'harmonique (*n*) vers l'infini, on se rapproche des signaux cible.

C'est ainsi qu'avec une somme à l'infini de sinus, on peut modéliser des signaux carrés, triangles ou, dans l'absolu, quelconques (pour autant que périodiques).

Application de la notion de spectre
===================================

La note jouée est un DO 3, de fréquence \$\approx 263Hz\$. Les harmoniques se succèdent tous les 263Hz à partir du fondamental. On a alors des harmoniques de rang n de fréquence $n*263$.

Entre les deux instruments, les pics du spectre sont au même endroit, mais leurs amplitudes diffèrent.
C'est ce qui défini le *timbre* de l'instrument.

Le son de véritables instruments (*i.e.* avec un humain au bout) est de loin plus chaleureux et *"complet"* que celui du synthé.

Entre la flute et le hautbois, le second semble plus *"riche"* et la flute plus nette.

Pour ce qui est de la bande téléphonique, force est de constater que l'abscence de la fondamentale n'est pas un obstacle à la perception de la voix et du timbre. On en conclue que l'oreille reconstruit le signal complet à partir des harmoniques perçues.
