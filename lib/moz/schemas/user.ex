defmodule Moz.User do
  # :userid-id
  # :usergroupid
  # :membergroupids
  # :displaygroupid
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
  #:options
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
  #:adminoptions
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
    has_one :account, Moz.Account
  end
end
