defmodule Moz.Post do
  use Ecto.Schema

  schema "post" do
    field :title, :string
    field :text, :string
    field :user_name, :string
    field :created_at, :utc_datetime
    
    field :allow_smile, :boolean
    field :allow_signature, :boolean
    field :visible, :boolean
    field :has_attach, :boolean
    field :ip_address, :string

    belongs_to :user, Moz.User
    belongs_to :report_thread, Moz.Thread
    belongs_to :thread, Moz.Thread
    belongs_to :parent, Moz.Post
    has_many :children, Moz.Post, foreign_key: :parent_id

  end

  # def change do
  #   create table(:post) do
  #     add :thread_id, references(:thread, on_delete: :delete_all), null: false
  #     add :parent_id, references(:post, on_delete: :delete_all), null: true
  #     add :user_name, :string, null: true
  #     add :user_id, references(:user, on_delete: :delete_all), null: false
  #     add :title, :string, null: false, default: ""
  #     add :created_at, :utc_datetime, null: false
  #     add :text, :text, null: true
  #     add :allow_smile, :boolean, null: false, default: false
  #     add :allow_signature, :boolean, null: false, default: false
  #     add :visible, :boolean, null: false, default: false
  #     add :has_attach, :boolean, null: false, default: false
  #     add :ip_address, :string, null: false, default: ''
  #     add :report_thread_id, references(:thread, on_delete: :delete_all), null: true
  #   end

  # end
# +----------------+----------------------+------+-----+---------+----------------+
# | Field          | Type                 | Null | Key | Default | Extra          |
# +----------------+----------------------+------+-----+---------+----------------+
# | postid         | int(10) unsigned     | NO   | PRI | NULL    | auto_increment |
# | threadid       | int(10) unsigned     | NO   | MUL | 0       |                |
# | parentid       | int(10) unsigned     | NO   |     | 0       |                |
# | username       | varchar(100)         | NO   |     |         |                |
# | userid         | int(10) unsigned     | NO   | MUL | 0       |                |
# | title          | varchar(250)         | NO   |     |         |                |
# | dateline       | int(10) unsigned     | NO   | MUL | 0       |                |
# | pagetext       | mediumtext           | YES  |     | NULL    |                |
# | allowsmilie    | smallint(6)          | NO   |     | 0       |                |
# | showsignature  | smallint(6)          | NO   |     | 0       |                |
# | ipaddress      | varchar(15)          | NO   |     |         |                |
# | iconid         | smallint(5) unsigned | NO   |     | 0       |                |
# | visible        | smallint(6)          | NO   |     | 0       |                |
# | attach         | smallint(5) unsigned | NO   |     | 0       |                |
# | infraction     | smallint(5) unsigned | NO   |     | 0       |                |
# | reportthreadid | int(10) unsigned     | NO   |     | 0       |                |
# +----------------+----------------------+------+-----+---------+----------------+
end
