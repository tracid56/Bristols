ESX                   = nil
local PlayerData      = {}
local base64MoneyIcon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALQAAAC0CAYAAAFKyjakAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA3FpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDE0IDc5LjE1MTQ4MSwgMjAxMy8wMy8xMy0xMjowOToxNSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo2ZmQ0ZWU2OC05ZTcyLWNhNDEtODk2My0xZGMyYjYzYTNhYTEiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6M0RFMEY5MDZFREFEMTFFNzk4Q0RBMDRCQkFENTYxMDEiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6M0RFMEY5MDVFREFEMTFFNzk4Q0RBMDRCQkFENTYxMDEiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjZmZDRlZTY4LTllNzItY2E0MS04OTYzLTFkYzJiNjNhM2FhMSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo2ZmQ0ZWU2OC05ZTcyLWNhNDEtODk2My0xZGMyYjYzYTNhYTEiLz4gPC9y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'

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

function EnableSocietyMoneyHUDElement()

  local societyMoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon .. '" style="width:20px; height:20px;">{{money}}</div>'

  ESX.UI.HUD.RegisterElement('faction_money', 6, 0, societyMoneyHUDElementTpl, {
    money = 0
  })

end

function DisableSocietyMoneyHUDElement()
  ESX.UI.HUD.RemoveElement('faction_money')
end

function UpdateSocietyMoneyHUDElement(money)

  ESX.UI.HUD.UpdateElement('faction_money', {
    money = money
  })

end

function OpenBossFactionMenu(society, close, options)

  local options  = options or {}
  local elements = {}

  local defaultOptions = {
    withdraw  = true,
    deposit   = true,
    wash      = true,
    employees = true,
    grades    = true
  }

  for k,v in pairs(defaultOptions) do
    if options[k] == nil then
      options[k] = v
    end
  end

  if options.withdraw then
    table.insert(elements, {label = _U('withdraw_society_money'), value = 'withdraw_society_money'})
  end

  if options.deposit then
    table.insert(elements, {label = _U('deposit_society_money'), value = 'deposit_money'})
  end

  if options.wash then
    table.insert(elements, {label = _U('wash_money'), value = 'wash_money'})
  end

  if options.employees then
    table.insert(elements, {label = _U('employee_management'), value = 'manage_employees'})
  end

  --if options.grades then
  --  table.insert(elements, {label = _U('salary_management'), value = 'manage_grades'})
  --end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'boss_actions_' .. society,
    {
      css = 'faction',
      title    = 'Boss',
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'withdraw_society_money' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society,
          {
            css = 'faction',
            title = _U('withdraw_amount')
          },
          function(data, menu)

            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()
              TriggerServerEvent('esx_societyfaction:withdrawMoney', society, amount)
            end

          end,
          function(data, menu)
            menu.close()
          end
        )

      end

      if data.current.value == 'deposit_money' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society,
          {
            css = 'faction',
            title = _U('deposit_amount')
          },
          function(data, menu)

            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()
              TriggerServerEvent('esx_societyfaction:depositMoney', society, amount)
            end

          end,
          function(data, menu)
            menu.close()
          end
        )

      end

      if data.current.value == 'wash_money' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'wash_money_amount_' .. society,
          {
            css = 'faction',
            title = _U('wash_money_amount')
          },
          function(data, menu)

            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()
              TriggerServerEvent('esx_societyfaction:washMoney', society, amount)
            end

          end,
          function(data, menu)
            menu.close()
          end
        )

      end

      if data.current.value == 'manage_employees' then
        OpenManageEmployeesMenu(society)
      end

      if data.current.value == 'manage_grades' then
        OpenManageGradesMenu(society)
      end

    end,
    function(data, menu)

      if close then
        close(data, menu)
      end

    end
  )

end


function OpenManageEmployeesMenu(society)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'manage_employees_' .. society,
    {
      css = 'faction',
      title    = _U('employee_management'),
      elements = {
        {label = _U('employee_list'), value = 'employee_list'},
        {label = _U('recruit'),       value = 'recruit'},
      }
    },
    function(data, menu)

      if data.current.value == 'employee_list' then
        OpenEmployeeList(society)
      end

      if data.current.value == 'recruit' then
        OpenRecruitMenu(society)
      end

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenEmployeeList(society)

  ESX.TriggerServerCallback('esx_societyfaction:getEmployees', function(employees)

    local elements = {
      head = {_U('employee'), _U('grade'), _U('actions')},
      rows = {}
    }

    for i=1, #employees, 1 do

      local gradeLabel = (employees[i].faction.grade_label == '' and employees[i].faction.label or employees[i].faction.grade_label)

      table.insert(elements.rows, {
        data = employees[i],
        cols = {
          employees[i].name,
          gradeLabel,
          '{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'employee_list_' .. society,
      elements,
      function(data, menu)

        local employee = data.data

        if data.value == 'promote' then
          menu.close()
          OpenPromoteMenu(society, employee)
        end

        if data.value == 'fire' then

          TriggerEvent('esx:showNotification', _U('you_have_fired', employee.name))

          ESX.TriggerServerCallback('esx_societyfaction:setFaction', function()
            OpenEmployeeList(society)
          end, employee.identifier, 'none', 0, 'fire')

        end

      end,
      function(data, menu)
        menu.close()
        OpenManageEmployeesMenu(society)
      end
    )

  end, society)

end

function OpenRecruitMenu(society)

  ESX.TriggerServerCallback('esx_societyfaction:getOnlinePlayers', function(players)

    local elements = {}

    for i=1, #players, 1 do
      if players[i].faction.name ~= society then
        table.insert(elements, {label = players[i].name, value = players[i].source, name = players[i].name, identifier = players[i].identifier})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'recruit_' .. society,
      {
        css = 'faction',
        title    = _U('recruiting'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'recruit_confirm_' .. society,
          {
            css = 'faction', -- MENU
            title    = _U('do_you_want_to_recruit', data.current.name),
            elements = {
              {label = _U('yes'), value = 'yes'},
              {label = _U('no'),  value = 'no'},
            }
          },
          function(data2, menu2)

            menu2.close()

            if data2.current.value == 'yes' then

              TriggerEvent('esx:showNotification', _U('you_have_hired', data.current.name))

              ESX.TriggerServerCallback('esx_societyfaction:setFaction', function()
                OpenRecruitMenu(society)
              end, data.current.identifier, society, 0, 'hire')

            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPromoteMenu(society, employee)

  ESX.TriggerServerCallback('esx_societyfaction:getFaction', function(faction)

    local elements = {}

    for i=1, #faction.grades, 1 do
      local gradeLabel = (faction.grades[i].label == '' and faction.label or faction.grades[i].label)
      table.insert(elements, {label = gradeLabel, value = faction.grades[i].grade, selected = (employee.faction.grade == faction.grades[i].grade)})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'promote_employee_' .. society,
      {
        css = ' faction',
        title    = _U('promote_employee', employee.name),
        elements = elements
      },
      function(data, menu)
        menu.close()

        TriggerEvent('esx:showNotification', _U('you_have_promoted', employee.name, data.current.label))

        ESX.TriggerServerCallback('esx_societyfaction:setFaction', function()
          OpenEmployeeList(society)
        end, employee.identifier, society, data.current.value, 'promote')

      end,
      function(data, menu)
        menu.close()
        OpenEmployeeList(society)
      end
    )

  end, society)

end

function OpenManageGradesMenu(society)

  ESX.TriggerServerCallback('esx_societyfaction:getFaction', function(faction)

    local elements = {}

    for i=1, #faction.grades, 1 do
      local gradeLabel = (faction.grades[i].label == '' and faction.label or faction.grades[i].label)
      table.insert(elements, {label = gradeLabel .. ' $' .. faction.grades[i].salary, value = faction.grades[i].grade})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'manage_grades_' .. society,
      {
        css = 'faction',
        title    = _U('salary_management'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society,
          {
            css = 'faction',
            title = _U('salary_amount')
          },
          function(data2, menu2)

            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu2.close()

              ESX.TriggerServerCallback('esx_societyfaction:setFactionSalary', function()
                OpenManageGradesMenu(society)
              end, society, data.current.value, amount)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, society)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

  PlayerData = xPlayer

  DisableSocietyMoneyHUDElement()

  if PlayerData.faction.grade_name == 'boss' then

    EnableSocietyMoneyHUDElement()

    ESX.TriggerServerCallback('esx_societyfaction:getSocietyMoney', function(money)
      UpdateSocietyMoneyHUDElement(money)
    end, PlayerData.faction.name)

  end

end)

RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction)

  PlayerData.faction = faction

  DisableSocietyMoneyHUDElement()

  if PlayerData.faction.grade_name == 'boss' then

    EnableSocietyMoneyHUDElement()

    ESX.TriggerServerCallback('esx_societyfaction:getSocietyMoney', function(money)
      UpdateSocietyMoneyHUDElement(money)
    end, PlayerData.faction.name)

  end

end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)

  if PlayerData.faction ~= nil and (PlayerData.faction.grade_name == 'boss') and 'society_' .. PlayerData.faction.name == society then
    UpdateSocietyMoneyHUDElement(money)
  end

end)

AddEventHandler('esx_societyfaction:openBossFactionMenu', function(society, close, options)
  OpenBossFactionMenu(society, close, options)
end)
