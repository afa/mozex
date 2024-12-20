tst:
	mix test
lint:
	mix credo --strict --all
routes:
	mix phx.routes
clean-all:
	docker image prune --all --force
	docker system prune --all --force
server:
	mix phx.server
sh:
	iex -S mix
sh-tst:
	MIX_ENV=test iex -S mix
lines:
	env zsh -c 'ls **/*.(ex|exs)'|grep -v '^deps'|grep -v '^_build'|xargs cat|wc -l
db:
	psql moz_dev
migrate:
	mix ecto.migrate
rollback:
	mix ecto.rollback
deploy: stop
	docker image build -t elixir/moz .
ssh:
	ssh -i .artifacts/deploy_key.rsa moz@project.megarulez.ru
stop:
	ssh -i .artifacts/deploy_key.rsa moz@project.megarulez.ru moz/bin/moz stop
start:
	ssh -i .artifacts/deploy_key.rsa moz@project.megarulez.ru moz/bin/env moz/bin/moz daemon
rmigrate:
	ssh -i .artifacts/deploy_key.rsa moz@project.megarulez.ru moz/bin/env moz/bin/moz eval "Moz.Release.migrate"
