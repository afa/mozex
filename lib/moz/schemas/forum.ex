defmodule Moz.Forum do
  use Ecto.Schema

  schema("forum") do
    field :title, :string
    field :title_clean, :string
    field :description, :string
    field :description_clean, :string
    field :position, :integer
    belongs_to :parent, Moz.Forum
  end
  # +-------------------+-----------------------+------+-----+----------+----------------+
  # | Field             | Type                  | Null | Key | Default  | Extra          |
  # +-------------------+-----------------------+------+-----+----------+----------------+
  # | forumid           | smallint(5) unsigned  | NO   | PRI | NULL     | auto_increment |
  # | styleid           | smallint(5) unsigned  | NO   |     | 0        |                |
  # | title             | varchar(100)          | NO   |     |          |                |
  # | title_clean       | varchar(100)          | NO   |     |          |                |
  # | description       | text                  | YES  |     | NULL     |                |
  # | description_clean | text                  | YES  |     | NULL     |                |
  # | options           | int(10) unsigned      | NO   |     | 0        |                |
  # | displayorder      | smallint(6)           | NO   |     | 0        |                |
  # | replycount        | int(10) unsigned      | NO   |     | 0        |                |
  # | lastpost          | int(11)               | NO   |     | 0        |                |
  # | lastposter        | varchar(100)          | NO   |     |          |                |
  # | lastthread        | varchar(250)          | NO   |     |          |                |
  # | lastthreadid      | int(10) unsigned      | NO   |     | 0        |                |
  # | lasticonid        | smallint(6)           | NO   |     | 0        |                |
  # | threadcount       | mediumint(8) unsigned | NO   |     | 0        |                |
  # | daysprune         | smallint(6)           | NO   |     | 0        |                |
  # | newpostemail      | text                  | YES  |     | NULL     |                |
  # | newthreademail    | text                  | YES  |     | NULL     |                |
  # | parentid          | smallint(6)           | NO   |     | 0        |                |
  # | parentlist        | varchar(250)          | NO   |     |          |                |
  # | password          | varchar(50)           | NO   |     |          |                |
  # | link              | varchar(200)          | NO   |     |          |                |
  # | childlist         | text                  | YES  |     | NULL     |                |
  # | lastpostid        | int(10) unsigned      | NO   |     | 0        |                |
  # | showprivate       | tinyint(3) unsigned   | NO   |     | 0        |                |
  # | defaultsortfield  | varchar(50)           | NO   |     | lastpost |                |
  # | defaultsortorder  | enum('asc','desc')    | NO   |     | desc     |                |
  # | lastprefixid      | varchar(25)           | NO   |     |          |                |
  # | imageprefix       | varchar(100)          | NO   |     |          |                |
  # +-------------------+-----------------------+------+-----+----------+----------------+
end
