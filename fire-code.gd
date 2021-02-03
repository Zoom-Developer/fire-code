func fire():
	if get_node('%s/WallChecker' % weapon).is_colliding():
		if get_node('%s/WallChecker' % weapon).get_collider() != null:
			if 'Wall' in get_node('%s/WallChecker' % weapon).get_collider().name:
				return
	if fire:
		if reload:
			return
		if ammo <= 0:
			if type == 'Enemy':
				reload()
			if !noammo:
				$NoAmmo.play()
				noammo = true
			return
		var bullet
		if weapon == 'RPS-6':
			bullet = rocket_path.instance()
		else:
			bullet = bullet_path.instance()
		var bullet2
		var bullet3
		if weapon == 'Shotgun':
			bullet2 = bullet_path.instance()
			bullet3 = bullet_path.instance()
			bullet2.bulletowner = owner
			bullet3.bulletowner = owner
			bullet2.damage = weaponstat[weapon].damage
			bullet3.damage = weaponstat[weapon].damage
			G.game.get_node('Bullets').add_child(bullet2)
			G.game.get_node('Bullets').add_child(bullet3)
			bullet2.global_rotation = global_rotation
			bullet3.global_rotation = global_rotation
			bullet2.global_position = get_node('Shotgun/Shotgun/BulletPos%s' % (int(currentpos.name) - 1)).global_position
			bullet3.global_position = get_node('Shotgun/Shotgun/BulletPos%s' % (int(currentpos.name) + 1)).global_position
			ammo -= 2
		bullet.bulletowner = owner
		bullet.damage = weaponstat[weapon].damage
		bullet.global_rotation = global_rotation
		G.game.get_node('Bullets').add_child(bullet)
		if weapon == 'Z-6':
			randomize()
			currentpos = [$"Z-6/Z-6/BulletPos",$"Z-6/Z-6/BulletPos2",$"Z-6/Z-6/BulletPos3",$"Z-6/Z-6/BulletPos4",$"Z-6/Z-6/BulletPos5",][int(rand_range(0, 5))]
		bullet.global_position = currentpos.global_position
		var imp
		if type == 'Player':
			imp = (get_global_mouse_position() - weapon_owner.position).normalized()
		else:
			imp = ((G.player.position - weapon_owner.position)).normalized()
		bullet.apply_impulse(Vector2(), imp * weaponstat[weapon].speed)
		if weapon == 'Shotgun':
			bullet2.apply_impulse(Vector2(), imp * weaponstat[weapon].speed)
			bullet3.apply_impulse(Vector2(), imp * weaponstat[weapon].speed)
		get_node('%s/Fire' % weapon).play()
		$FireTimer.start(weaponstat[weapon].ready)
		fire = false
		ammo -= 1
