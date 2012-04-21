Tools
=====

Objectif
--------

L'objectif *in fine* est de fournir quelques outis permettant :

* la création facile de docs liés à la fac
* l'apprentissage

Ce fichier est un ``README`` général pour ces outils.

``mkdefsheet.pl``
-----------------

Un simple script **perl** pour la création de listes de définitions.

La liste est enregistrée au format **LaTeX** dans le fichier dont le nom est passé en paramètre.
Le script se lance de la manière suivante::

    $ perl mkdefsheet.pl nom_du_fichier

*Note : Vous ne devez spécifier **qu'un seul** paramètre*

Le script vous demandera **Definen** (le mot à définir) puis **definiendum** (sa définition).

Vous n'aurez qu'à ouvrir le fichier produit et à remplacer le titre, auteur & date.
