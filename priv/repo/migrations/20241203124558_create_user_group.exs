defmodule Moz.Repo.Migrations.CreateUserGroup do
  use Ecto.Migration

  def change do
    create table(:user_group) do
      add :title, :string
      add :description, :string
      add :user_title, :string
      add :password_expires_in, :integer
      add :passwordhistory, :integer
      add :pm_quota, :integer
      add :pm_send_max, :integer
      add :open_tag, :string
      add :close_tag, :string
      add :can_override, :boolean
      add :is_public_group, :boolean
      add :forum_permissions, :integer
      add :pm_permissions, :integer
      add :calendar_permissions, :integer
      add :wol_permissions, :integer
      add :admin_permissions, :integer
      add :generic_permissions, :integer
      add :generic_options, :integer
      add :attach_limit, :integer
      add :avatar_max_width, :integer
      add :avatar_max_height, :integer
      add :avatar_max_size, :integer
      add :profile_pic_max_width, :integer
      add :profile_pic_max_height, :integer
      add :profile_pic_max_size, :integer
      add :signature_permissions, :integer
      add :sig_pic_max_width, :integer
      add :sig_pic_max_height, :integer
      add :sig_pic_max_size, :integer
      add :sig_max_images, :integer
      add :sig_max_size_bbcode, :integer
      add :sig_max_chars, :integer
      add :sig_max_raw_chars, :integer
      add :sig_max_lines, :integer
      add :visitor_message_permissions, :integer
      add :social_group_permissions, :integer
      add :user_css_permissions, :integer
      add :album_permissions, :integer
      add :album_pic_max_width, :integer
      add :album_pic_max_height, :integer
      add :album_pic_max_size, :integer
      add :album_max_pics, :integer
      add :album_max_size, :integer
      add :generic_permissions_2, :integer
      add :photo_plog_permissions, :integer
      add :photo_plog_max_file_size, :integer
      add :photo_plog_max_file_limit, :integer
      add :pm_throttle_quantity, :boolean
      add :group_icon_max_size, :integer
      add :maximum_social_groups, :integer
    end
  end
  # +---------------------------+----------------------+------+-----+---------+----------------+
  # | Field                     | Type                 | Null | Key | Default | Extra          |
  # +---------------------------+----------------------+------+-----+---------+----------------+
  # | usergroupid               | smallint(5) unsigned | NO   | PRI | NULL    | auto_increment |
  # | title                     | varchar(100)         | NO   |     |         |                |
  # | description               | varchar(250)         | NO   |     |         |                |
  # | usertitle                 | varchar(100)         | NO   |     |         |                |
  # | passwordexpires           | smallint(5) unsigned | NO   |     | 0       |                |
  # | passwordhistory           | smallint(5) unsigned | NO   |     | 0       |                |
  # | pmquota                   | smallint(5) unsigned | NO   |     | 0       |                |
  # | pmsendmax                 | smallint(5) unsigned | NO   |     | 5       |                |
  # | opentag                   | varchar(100)         | NO   |     |         |                |
  # | closetag                  | varchar(100)         | NO   |     |         |                |
  # | canoverride               | smallint(5) unsigned | NO   |     | 0       |                |
  # | ispublicgroup             | smallint(5) unsigned | NO   |     | 0       |                |
  # | forumpermissions          | int(10) unsigned     | NO   |     | 0       |                |
  # | pmpermissions             | int(10) unsigned     | NO   |     | 0       |                |
  # | calendarpermissions       | int(10) unsigned     | NO   |     | 0       |                |
  # | wolpermissions            | int(10) unsigned     | NO   |     | 0       |                |
  # | adminpermissions          | int(10) unsigned     | NO   |     | 0       |                |
  # | genericpermissions        | int(10) unsigned     | NO   |     | 0       |                |
  # | genericoptions            | int(10) unsigned     | NO   |     | 0       |                |
  # | attachlimit               | int(10) unsigned     | NO   |     | 0       |                |
  # | avatarmaxwidth            | smallint(5) unsigned | NO   |     | 0       |                |
  # | avatarmaxheight           | smallint(5) unsigned | NO   |     | 0       |                |
  # | avatarmaxsize             | int(10) unsigned     | NO   |     | 0       |                |
  # | profilepicmaxwidth        | smallint(5) unsigned | NO   |     | 0       |                |
  # | profilepicmaxheight       | smallint(5) unsigned | NO   |     | 0       |                |
  # | profilepicmaxsize         | int(10) unsigned     | NO   |     | 0       |                |
  # | signaturepermissions      | int(10) unsigned     | NO   |     | 0       |                |
  # | sigpicmaxwidth            | smallint(5) unsigned | NO   |     | 0       |                |
  # | sigpicmaxheight           | smallint(5) unsigned | NO   |     | 0       |                |
  # | sigpicmaxsize             | int(10) unsigned     | NO   |     | 0       |                |
  # | sigmaximages              | smallint(5) unsigned | NO   |     | 0       |                |
  # | sigmaxsizebbcode          | smallint(5) unsigned | NO   |     | 0       |                |
  # | sigmaxchars               | smallint(5) unsigned | NO   |     | 0       |                |
  # | sigmaxrawchars            | smallint(5) unsigned | NO   |     | 0       |                |
  # | sigmaxlines               | smallint(5) unsigned | NO   |     | 0       |                |
  # | visitormessagepermissions | int(10) unsigned     | NO   |     | 0       |                |
  # | socialgrouppermissions    | int(10) unsigned     | NO   |     | 0       |                |
  # | usercsspermissions        | int(10) unsigned     | NO   |     | 0       |                |
  # | albumpermissions          | int(10) unsigned     | NO   |     | 0       |                |
  # | albumpicmaxwidth          | smallint(5) unsigned | NO   |     | 0       |                |
  # | albumpicmaxheight         | smallint(5) unsigned | NO   |     | 0       |                |
  # | albumpicmaxsize           | int(10) unsigned     | NO   |     | 0       |                |
  # | albummaxpics              | int(10) unsigned     | NO   |     | 0       |                |
  # | albummaxsize              | int(10) unsigned     | NO   |     | 0       |                |
  # | genericpermissions2       | int(10) unsigned     | NO   |     | 0       |                |
  # | photoplogpermissions      | int(10) unsigned     | NO   |     | 0       |                |
  # | photoplogmaxfilesize      | int(10)              | NO   |     | 512000  |                |
  # | photoplogmaxfilelimit     | int(10)              | NO   |     | 100     |                |
  # | pmthrottlequantity        | int(10) unsigned     | NO   |     | 0       |                |
  # | groupiconmaxsize          | int(10) unsigned     | NO   |     | 0       |                |
  # | maximumsocialgroups       | int(10) unsigned     | NO   |     | 0       |                |
  # +---------------------------+----------------------+------+-----+---------+----------------+
end
