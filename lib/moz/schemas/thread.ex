defmodule Moz.Thread do
  use Ecto.Schema

  schema("thread") do
    field :title, :string
    belongs_to :forum, Moz.Forum
    field :last_post_at, :utc_datetime
    field :created_at, :utc_datetime
    field :open, :boolean
    field :visible, :boolean
    field :sticky, :boolean
    field :poster_name
    belongs_to :poster, Moz.User
    has_many :posts, Moz.Post
  end
end
# --------------+----------------------+------+-----+---------+----------------+
# | Field        | Type                 | Null | Key | Default | Extra          |
# +--------------+----------------------+------+-----+---------+----------------+
# | threadid     | int(10) unsigned     | NO   | PRI | NULL    | auto_increment |
# | title        | varchar(250)         | NO   |     |         |                |
# | firstpostid  | int(10) unsigned     | NO   |     | 0       |                |
# | lastpost     | int(10) unsigned     | NO   | MUL | 0       |                |
# | forumid      | smallint(5) unsigned | NO   | MUL | 0       |                |
# | pollid       | int(10) unsigned     | NO   | MUL | 0       |                |
# | open         | smallint(6)          | NO   |     | 0       |                |
# | replycount   | int(10) unsigned     | NO   |     | 0       |                |
# | hiddencount  | int(10) unsigned     | NO   |     | 0       |                |
# | postusername | varchar(100)         | NO   |     |         |                |
# | postuserid   | int(10) unsigned     | NO   | MUL | 0       |                |
# | lastposter   | varchar(100)         | NO   |     |         |                |
# | dateline     | int(10) unsigned     | NO   | MUL | 0       |                |
# | views        | int(10) unsigned     | NO   |     | 0       |                |
# | iconid       | smallint(5) unsigned | NO   |     | 0       |                |
# | notes        | varchar(250)         | NO   |     |         |                |
# | visible      | smallint(6)          | NO   |     | 0       |                |
# | sticky       | smallint(6)          | NO   |     | 0       |                |
# | votenum      | smallint(5) unsigned | NO   |     | 0       |                |
# | votetotal    | smallint(5) unsigned | NO   |     | 0       |                |
# | attach       | smallint(5) unsigned | NO   |     | 0       |                |
# | similar      | varchar(55)          | NO   |     |         |                |
# | deletedcount | smallint(5) unsigned | NO   |     | 0       |                |
# | lastpostid   | int(10) unsigned     | NO   |     | 0       |                |
# | prefixid     | varchar(25)          | NO   | MUL |         |                |
# | taglist      | mediumtext           | YES  |     | NULL    |                |
# +--------------+----------------------+------+-----+---------+----------------+
