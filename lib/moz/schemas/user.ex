defmodule Moz.User do
  # :userid-id
  # :usergroupid-user_group_id
  # :membergroupids-tmp_member_group_ids
  # :displaygroupid-display_group_id
  # :username-name
  # :password-
  # :passworddate-password_on
  # :email-
  # :styleid
  # :parentemail
  # :homepage->Contact
  # :icq->Contact
  # :aim->Contact
  # :yahoo->Contact
  # :msn->Contact
  # :skype->Contact
  # :showvbcode
  # :showbirthday
  # :usertitle-user_title
  # :customtitle
  # :joindate
  # :daysprune
  # :lastvisit
  #:lastactivity
  #:lastpost
  #:posts
  #:reputation
  #:reputationlevelid
  #:timezoneoffset
  #:pmpopup
  #:avatarid
  #:avatarrevision
  #:profilepicrevision
  #:options-
  #:birthday
  #:birthday_search
  #:maxposts
  #:startofweek
  #:ipaddress
  #:referrerid
  #:languageid
  #:emailstamp
  #:threadedmode
  #:autosubscribe
  #:pmtotal
  #:pmunread
  #:salt-
  #:adminoptions-admin_options
  #:lastpostid
  #:sigpicrevision
  #:ipoints
  #:infractions
  #:warnings
  #:infractiongroupids
  #:infractiongroupid :cfrules_read_status :profilevisits :friendcount :friendreqcount :vmunreadcount :vmmoderatedcount :socgroupinvitecount :socgroupreqcount :pcunreadcount :pcmoderatedcount :gmmoderatedcount :photoplog_filecount :photoplog_commentcount :showcybstats

  use Ecto.Schema

  schema("user") do
    field :name, :string
    field :email, :string
    field :password, :string
    field :password_on, :date
    field :salt, :string
    field :user_title, :string
    field :posts_count, :integer, virtual: true
    has_one :account, Moz.Account

      # add :user_group_id, references("user_group", on_delete: :delete_all), null: false
      # add :tmp_member_group_ids, :string, null: true
      # add :display_group_id, references("user_group", on_delete: :delete_all), null: true
      # add :options, :integer, null: true
      # add :admin_options, :integer, null: true
    
  end
end
