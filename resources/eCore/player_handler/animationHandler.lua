local animationList = {
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour boire un café",
        msg_cant = "~r~Vous n'êtes pas autorisé à utiliser cette cafetière",
        coords = vector3(1844.7, 3680.65, 34.27),
        heading = 296.82,
        job = "ambulance",
        action          = function()
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_food["coffee"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_food["coffee"].AnimationOptions then
                if anim_list_food["coffee"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_food["coffee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end
            
                elseif anim_list_food["coffee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_food["coffee"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_food["coffee"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_food["coffee"].AnimationOptions then
                if anim_list_food["coffee"].AnimationOptions.EmoteDuration == nil then 
                  anim_list_food["coffee"].AnimationOptions.EmoteDuration = -1
                  AttachWait = 0
                else
                  AnimationDuration = anim_list_food["coffee"].AnimationOptions.EmoteDuration
                  AttachWait = anim_list_food["coffee"].AnimationOptions.EmoteDuration
                end
            
                if anim_list_food["coffee"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_food["coffee"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_food["coffee"].AnimationOptions.PtfxName
                    if anim_list_food["coffee"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_food["coffee"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_food["whiskey"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_food["coffee"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_food["coffee"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_food["coffee"].AnimationOptions then
                if anim_list_food["coffee"].AnimationOptions.Prop then
                    PropName = anim_list_food["coffee"].AnimationOptions.Prop
                    PropBone = anim_list_food["coffee"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_food["coffee"].AnimationOptions.PropPlacement)
                    if anim_list_food["coffee"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_food["coffee"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_food["coffee"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_food["coffee"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end

            TriggerEvent("Extasy:AddThirst", 7.5)
        end
    },
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour faire pipi",
        msg_cant = "~r~Vous n'êtes pas autorisé à utiliser ces toilettes",
        coords = vector3(1822.03, 3665.7, 34.27),
        heading = 211.1,
        job = false,
        action          = function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_action["pee"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end

                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_action["pee"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteDuration == nil then 
                anim_list_action["pee"].AnimationOptions.EmoteDuration = -1
                AttachWait = 0
                else
                AnimationDuration = anim_list_action["pee"].AnimationOptions.EmoteDuration
                AttachWait = anim_list_action["pee"].AnimationOptions.EmoteDuration
                end

                if anim_list_action["pee"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_action["pee"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_action["pee"].AnimationOptions.PtfxName
                    if anim_list_action["pee"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_action["pee"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_action["pee"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_action["pee"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_action["pee"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.Prop then
                    PropName = anim_list_action["pee"].AnimationOptions.Prop
                    PropBone = anim_list_action["pee"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.PropPlacement)
                    if anim_list_action["pee"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_action["pee"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_action["pee"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
            PtfxStart()
            Wait(15000)
            PtfxStop()
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1), false)
            TriggerEvent("Extasy:RemoveThirst", token, 7.5)
        end
    },
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour lire un bouquin",
        msg_cant = "~r~Vous n'êtes pas autorisé à utiliser ces bouquins",
        coords = vector3(1839.08, 3682.89, 34.27),
        heading = 27.46,
        job = "ambulance",
        action          = function()
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_food["book"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_food["book"].AnimationOptions then
                if anim_list_food["book"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_food["book"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end
            
                elseif anim_list_food["book"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_food["book"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_food["book"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_food["book"].AnimationOptions then
                if anim_list_food["book"].AnimationOptions.EmoteDuration == nil then 
                  anim_list_food["book"].AnimationOptions.EmoteDuration = -1
                  AttachWait = 0
                else
                  AnimationDuration = anim_list_food["book"].AnimationOptions.EmoteDuration
                  AttachWait = anim_list_food["book"].AnimationOptions.EmoteDuration
                end
            
                if anim_list_food["book"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_food["book"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_food["book"].AnimationOptions.PtfxName
                    if anim_list_food["book"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_food["book"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_food["book"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_food["book"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_food["book"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_food["book"].AnimationOptions then
                if anim_list_food["book"].AnimationOptions.Prop then
                    PropName = anim_list_food["book"].AnimationOptions.Prop
                    PropBone = anim_list_food["book"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_food["book"].AnimationOptions.PropPlacement)
                    if anim_list_food["book"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_food["book"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_food["book"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_food["book"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
        end
    },
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour faire pipi",
        msg_cant = "~r~Vous n'êtes pas autorisé à utiliser ces toilettes",
        coords = vector3(330.05, -1372.49, 32.51),
        heading = 135.84,
        job = false,
        action          = function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_action["pee"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end

                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_action["pee"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteDuration == nil then 
                anim_list_action["pee"].AnimationOptions.EmoteDuration = -1
                AttachWait = 0
                else
                AnimationDuration = anim_list_action["pee"].AnimationOptions.EmoteDuration
                AttachWait = anim_list_action["pee"].AnimationOptions.EmoteDuration
                end

                if anim_list_action["pee"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_action["pee"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_action["pee"].AnimationOptions.PtfxName
                    if anim_list_action["pee"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_action["pee"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_action["pee"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_action["pee"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_action["pee"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.Prop then
                    PropName = anim_list_action["pee"].AnimationOptions.Prop
                    PropBone = anim_list_action["pee"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.PropPlacement)
                    if anim_list_action["pee"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_action["pee"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_action["pee"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
            PtfxStart()
            Wait(15000)
            PtfxStop()
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1), false)
            TriggerEvent("Extasy:RemoveThirst", token, 7.5)
        end
    },
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour faire pipi",
        msg_cant = "~r~Vous n'êtes pas autorisé à utiliser ces toilettes",
        coords = vector3(331.17, -1373.49, 32.51),
        heading = 136.16,
        job = false,
        action          = function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_action["pee"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end

                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_action["pee"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteDuration == nil then 
                anim_list_action["pee"].AnimationOptions.EmoteDuration = -1
                AttachWait = 0
                else
                AnimationDuration = anim_list_action["pee"].AnimationOptions.EmoteDuration
                AttachWait = anim_list_action["pee"].AnimationOptions.EmoteDuration
                end

                if anim_list_action["pee"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_action["pee"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_action["pee"].AnimationOptions.PtfxName
                    if anim_list_action["pee"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_action["pee"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_action["pee"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_action["pee"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_action["pee"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.Prop then
                    PropName = anim_list_action["pee"].AnimationOptions.Prop
                    PropBone = anim_list_action["pee"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.PropPlacement)
                    if anim_list_action["pee"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_action["pee"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_action["pee"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
            PtfxStart()
            Wait(15000)
            PtfxStop()
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1), false)
            TriggerEvent("Extasy:RemoveThirst", token, 7.5)
        end
    },
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour faire pipi",
        msg_cant = "~r~Vous n'êtes pas autorisé à utiliser ces toilettes",
        coords = vector3(332.26, -1374.43, 32.51),
        heading = 135.0,
        job = false,
        action          = function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_action["pee"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end

                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_action["pee"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_action["pee"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.EmoteDuration == nil then 
                anim_list_action["pee"].AnimationOptions.EmoteDuration = -1
                AttachWait = 0
                else
                AnimationDuration = anim_list_action["pee"].AnimationOptions.EmoteDuration
                AttachWait = anim_list_action["pee"].AnimationOptions.EmoteDuration
                end

                if anim_list_action["pee"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_action["pee"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_action["pee"].AnimationOptions.PtfxName
                    if anim_list_action["pee"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_action["pee"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_action["pee"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_action["pee"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_action["pee"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_action["pee"].AnimationOptions then
                if anim_list_action["pee"].AnimationOptions.Prop then
                    PropName = anim_list_action["pee"].AnimationOptions.Prop
                    PropBone = anim_list_action["pee"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.PropPlacement)
                    if anim_list_action["pee"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_action["pee"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_action["pee"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_action["pee"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
            PtfxStart()
            Wait(15000)
            PtfxStop()
            ClearPedTasks(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1), false)
            TriggerEvent("Extasy:RemoveThirst", token, 7.5)
        end
    },
    {
        name = "Appt Executive Rich",
        msg = "~g~Appuyez sur E pour prendre un donut",
        msg_cant = "~r~Vous n'êtes pas autorisé à prendre un donut",
        coords = vector3(315.19, -1404.6, 32.51),
        heading = 143.13,
        job = "ambulance",
        action          = function()
            ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_food["donut"])
            AnimationDuration = -1

            LoadAnim(ChosenDict)

            if anim_list_food["donut"].AnimationOptions then
                if anim_list_food["donut"].AnimationOptions.EmoteLoop then
                    MovementType = 1
                if anim_list_food["donut"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                end
            
                elseif anim_list_food["donut"].AnimationOptions.EmoteMoving then
                    MovementType = 51
                elseif anim_list_food["donut"].AnimationOptions.EmoteMoving == false then
                    MovementType = 0
                elseif anim_list_food["donut"].AnimationOptions.EmoteStuck then
                    MovementType = 50
                end
            else
                MovementType = 0
            end

            if anim_list_food["donut"].AnimationOptions then
                if anim_list_food["donut"].AnimationOptions.EmoteDuration == nil then 
                  anim_list_food["donut"].AnimationOptions.EmoteDuration = -1
                  AttachWait = 0
                else
                  AnimationDuration = anim_list_food["donut"].AnimationOptions.EmoteDuration
                  AttachWait = anim_list_food["donut"].AnimationOptions.EmoteDuration
                end
            
                if anim_list_food["donut"].AnimationOptions.PtfxAsset then
                    PtfxAsset = anim_list_food["donut"].AnimationOptions.PtfxAsset
                    PtfxName = anim_list_food["donut"].AnimationOptions.PtfxName
                    if anim_list_food["donut"].AnimationOptions.PtfxNoProp then
                        PtfxNoProp = anim_list_food["donut"].AnimationOptions.PtfxNoProp
                    else
                        PtfxNoProp = false
                    end
                    Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_food["donut"].AnimationOptions.PtfxPlacement)
                    PtfxInfo = anim_list_food["donut"].AnimationOptions.PtfxInfo
                    PtfxWait = anim_list_food["donut"].AnimationOptions.PtfxWait
                    PtfxNotif = false
                    PtfxPrompt = true
                    PtfxThis(PtfxAsset)
                else
                    PtfxPrompt = false
                end
            end

            TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
            RemoveAnimDict(ChosenDict)

            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation

            if anim_list_food["donut"].AnimationOptions then
                if anim_list_food["donut"].AnimationOptions.Prop then
                    PropName = anim_list_food["donut"].AnimationOptions.Prop
                    PropBone = anim_list_food["donut"].AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_food["donut"].AnimationOptions.PropPlacement)
                    if anim_list_food["donut"].AnimationOptions.SecondProp then
                        SecondPropName = anim_list_food["donut"].AnimationOptions.SecondProp
                        SecondPropBone = anim_list_food["donut"].AnimationOptions.SecondPropBone
                        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_food["donut"].AnimationOptions.SecondPropPlacement)
                        SecondPropEmote = true
                    else
                        SecondPropEmote = false
                    end
                    Wait(0)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
            Wait(15000)
            PtfxStop()
            ClearPedTasks(GetPlayerPed(-1))
            DestroyAllProps()
            TriggerEvent("Extasy:AddHunger", token, 7.5)
            TriggerEvent("Extasy:RemoveThirst", token, 4.5)
        end
    },
}

Citizen.CreateThread(function()
    while true do
        local near_animation = false
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(animationList) do
            local dst = GetDistanceBetweenCoords(pedCoords, v.coords, true)

            if dst <= 1.5 then
                near_animation = true
                ESX.ShowHelpNotification("~p~"..v.msg)
                if IsControlJustReleased(1, 38) then
                    if v.job == false then
                        SetEntityHeading(GetPlayerPed(-1), v.heading)
                        v.action()
                    else
                        if playerJob == v.job then
                            SetEntityHeading(GetPlayerPed(-1), v.heading)
                            v.action()
                        else
                            Extasy.ShowNotification(v.msg_cant)
                        end
                    end
                end
            end
        end

        if near_animation then
            Wait(1)
        else
            Wait(1500)
        end
    end
end)

animation_sleep = false
function sleep()
    animation_sleep = true
    Citizen.CreateThread(function()
        while animation_sleep do
            Wait(0)
            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
        end
    end)
end

animation_pointing = false
function start_pointing()
    animation_pointing = true
    Citizen.CreateThread(function()
        while animation_pointing do
            Wait(0)
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
                stopPointing()
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                if not IsPedOnFoot(PlayerPedId()) then
                    stopPointing()
                else
                    local ped = GetPlayerPed(-1)
                    local camPitch = GetGameplayCamRelativePitch()
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
                    camPitch = (camPitch + 70.0) / 112.0
    
                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
                    camHeading = (camHeading + 180.0) / 360.0
    
                    local blocked = 0
                    local nn = 0
    
                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)
    
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
    
                end
            end
        end
    end)
end

takeUseAnimation = function(data)
    ChosenDict,ChosenAnimation,ename = table.unpack(anim_list_food[data])
    AnimationDuration = -1

    LoadAnim(ChosenDict)

    if anim_list_food[data].AnimationOptions then
        if anim_list_food[data].AnimationOptions.EmoteLoop then
            MovementType = 1
        if anim_list_food[data].AnimationOptions.EmoteMoving then
            MovementType = 51
        end
    
        elseif anim_list_food[data].AnimationOptions.EmoteMoving then
            MovementType = 51
        elseif anim_list_food[data].AnimationOptions.EmoteMoving == false then
            MovementType = 0
        elseif anim_list_food[data].AnimationOptions.EmoteStuck then
            MovementType = 50
        end
    else
        MovementType = 0
    end

    if anim_list_food[data].AnimationOptions then
        if anim_list_food[data].AnimationOptions.EmoteDuration == nil then 
          anim_list_food[data].AnimationOptions.EmoteDuration = -1
          AttachWait = 0
        else
          AnimationDuration = anim_list_food[data].AnimationOptions.EmoteDuration
          AttachWait = anim_list_food[data].AnimationOptions.EmoteDuration
        end
    
        if anim_list_food[data].AnimationOptions.PtfxAsset then
            PtfxAsset = anim_list_food[data].AnimationOptions.PtfxAsset
            PtfxName = anim_list_food[data].AnimationOptions.PtfxName
            if anim_list_food[data].AnimationOptions.PtfxNoProp then
                PtfxNoProp = anim_list_food[data].AnimationOptions.PtfxNoProp
            else
                PtfxNoProp = false
            end
            Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(anim_list_food[data].AnimationOptions.PtfxPlacement)
            PtfxInfo = anim_list_food[data].AnimationOptions.PtfxInfo
            PtfxWait = anim_list_food[data].AnimationOptions.PtfxWait
            PtfxNotif = false
            PtfxPrompt = true
            PtfxThis(PtfxAsset)
        else
            PtfxPrompt = false
        end
    end

    TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)

    IsInAnimation = true
    MostRecentDict = ChosenDict
    MostRecentAnimation = ChosenAnimation

    if anim_list_food[data].AnimationOptions then
        if anim_list_food[data].AnimationOptions.Prop then
            PropName = anim_list_food[data].AnimationOptions.Prop
            PropBone = anim_list_food[data].AnimationOptions.PropBone
            PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(anim_list_food[data].AnimationOptions.PropPlacement)
            if anim_list_food[data].AnimationOptions.SecondProp then
                SecondPropName = anim_list_food[data].AnimationOptions.SecondProp
                SecondPropBone = anim_list_food[data].AnimationOptions.SecondPropBone
                SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(anim_list_food[data].AnimationOptions.SecondPropPlacement)
                SecondPropEmote = true
            else
                SecondPropEmote = false
            end
            Wait(0)
            AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
            if SecondPropEmote then
                AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
            end
        end
    end
    
    Wait(15000)
    PtfxStop()
    ClearPedTasks(GetPlayerPed(-1))
    DestroyAllProps()
end