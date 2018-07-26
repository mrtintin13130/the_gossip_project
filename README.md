# The Gossip Project

## Le pitch

>Chez THP, on est tous fan de cette superbe série d'anticipation qu'est Gossip girl et on va créer une plateforme pour pouvoir commérer tous ensemble 😏. Sur ce super réseau social, un utilisateur va s'inscrire, renseigner son prénom et nom, son mail et son age, puis il précisera sa ville avec une recherche par code postal. Il aura ensuite toutes les fonctionnalités qui feront de cette appli une future licorne :

>    Les utilisateurs peuvent créer des potins : "askip john est célib hihi"
    Les utilisateurs en créant des potins peuvent mettre un ou plusieurs tags sur les potins : #romance
    Les utilisateurs peuvent commenter des potins : "ahiii j'savé pa lol 💁‍♂️"
    Et puisqu'une appli de potins sans un système BG de commentaire serait bidon, on va faire en sorte qu'il est possible de commenter des commentaires
    Les utilisateurs peuvent liker des potins
    Les utilisateurs peuvent contacter leur commères favories en MP pour des exclus mondiales

>L'utilisateur pourra donc rechercher les potins par ville, par utilisateurs, par date (plus récent ou plus ancien), par nombre de likes, par tags, pour trouver les potins les plus croustillants.


## Models

## users
|Column|Type|
|------|----|
|first_name|string|
|last_name|string|
|description|text|
|email|string|
|age|integer|
### Associations
- belongs_to :city

## cities
|Column|Type|
|------|----|
|name|string|
|postal_code|integer|
### Associations
- has_many :users


## gossips
|Column|Type|
|------|----|
|title|string|
|content|text|
|date|timestamp|

### Associations
- belongs_to :user
- has_and_belongs_to_many :tags
- has_many :likes, as: :commentable
- has_many :comments, as: :commentable

Declaring the polymorphism here, allowing to use `commentable` when we want to have the choice between `like` and `comment`

## tags
|Column|Type|
|------|----|
|title|string|
### Associations
-  has_and_belongs_to_many :gossips

## privatemessages
|Column|Type|
|------|----|
|content|text|
|date|timestamp|
### Associations
- belongs_to :sender, class_name: 'User'
- belongs_to :receiver, class_name: 'User'

Both users with different roles

## comments
|Column|Type|
|------|----|
|content|text|
### Associations
- belongs_to :user
- belongs_to :commentable, polymorphic: true
- has_many :likes, as: :commentable
- has_many :comments, as: :commentable

## likes
No content
### Associations
- belongs_to :user
- belongs_to :commentable, polymorphic: true

`commentable` stands for either a `comment` or a `gossip`

## gossips_tags
Created to handle the many-to-many relationship
|Column|Type|
|------|----|
|gossip_id|reference|
|tag_id|reference|
### Associations
- belongs_to :gossip
- belongs_to :tag
## Usage

```sh
$ bundle install
$ rails db:migrate
$ rails db:seed
```

## Gems
We use :
- `faker` to populate the database with phony names, emails etc..
