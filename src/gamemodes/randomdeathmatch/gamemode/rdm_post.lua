print("rdm_post.lua")

timer.Create( "playerheal", 0.5, 0, function()

  for k, v in pairs( ents.GetAll() ) do

    if v:IsPlayer() then

      if v:Health() < 100 and v:Alive() then

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
