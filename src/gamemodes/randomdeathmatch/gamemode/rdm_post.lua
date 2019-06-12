print("rdm_post.lua")

timer.Create( "playerheal", 0.25, 0, function()

  for k, v in pairs( ents.GetAll() ) do

    if v:IsPlayer() then
		
		if v:GetVar( "hurtTimer" ) > 0 then
			v:SetVar( "hurtTimer", v:GetVar( "hurtTimer" ) - 1 )
		end
		
		if v:GetVar( "hurtTimer" ) < 0 then
			v:SetVar( "hurtTimer", 0)
		end
		
      if v:Health() < 100 and v:Alive() and v:GetVar( "hurtTimer" ) == 0 then

        v:SetHealth( v:Health() + 1 )

      end

    end

  end

end )

timer.Create( "weaponcleanup", 15, 0, function()

  for k, v in pairs( ents.GetAll() ) do

    if v:GetVar( "dropped" ) == 1 then

      v:SetVar( "droppedTime", v:GetVar( "droppedTime" ) + 15 )
      if v:GetVar( "droppedTime" ) >= 120 then

        v:Remove()

      end

    end

  end

end )

print(">Done!")
