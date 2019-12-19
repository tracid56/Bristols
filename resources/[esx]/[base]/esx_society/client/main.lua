ESX                   = nil
local PlayerData      = {}
local base64MoneyIcon = 'data:image/png;base64,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'

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

function EnableSocietyMoneyHUDElement()

  local societyMoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon .. '" style="width:32px; height:20px;">{{money}}</div>'

  ESX.UI.HUD.RegisterElement('society_money', 4, 0, societyMoneyHUDElementTpl, {
    money = 0
  })

end

function DisableSocietyMoneyHUDElement()
  ESX.UI.HUD.RemoveElement('society_money')
end

function UpdateSocietyMoneyHUDElement(money)

  ESX.UI.HUD.UpdateElement('society_money', {
    money = money
  })

end

function OpenBossMenu(society, close, options)

  local options  = options or {}
  local elements = {}

  local defaultOptions = {
    withdraw  = true,
    deposit   = true,
    wash      = false,
    employees = true,
    grades    = false,
    stocks    = true,
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

  if options.grades then
    table.insert(elements, {label = _U('salary_management'), value = 'manage_grades'})
  end

  if options.stocks then
    table.insert(elements, {label = _U('chest'), value = 'manage_stocks'})
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'boss_actions_' .. society,
    {
      css = 'job',
      title    = 'Patron',
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'withdraw_society_money' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society,
          {
            css = 'job',
            title = _U('withdraw_amount')
          },
          function(data, menu)

            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()
              TriggerServerEvent('esx_society:withdrawMoney', society, amount)
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
            css = 'job',
            title = _U('deposit_amount')
          },
          function(data, menu)

            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()
              TriggerServerEvent('esx_society:depositMoney', society, amount)
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
            css = 'job',
            title = _U('wash_money_amount')
          },
          function(data, menu)

            local amount = tonumber(data.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()
              TriggerServerEvent('esx_society:washMoney', society, amount)
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

      if data.current.value == 'manage_stocks' then
        OpenManageStocksMenu(society, function(data, menu)
          menu.close()
        end)
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
      css = 'job',
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

  ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)

    local elements = {
      head = {_U('employee'), _U('grade'), _U('actions')},
      rows = {}
    }

    for i=1, #employees, 1 do

      local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)

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

          ESX.TriggerServerCallback('esx_society:setJob', function()
            OpenEmployeeList(society)
          end, employee.identifier, 'unemployed', 0, 'fire')

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

  ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)

    local elements = {}

    for i=1, #players, 1 do
      if players[i].job.name ~= society then
        table.insert(elements, {label = players[i].name, value = players[i].source, name = players[i].name, identifier = players[i].identifier})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'recruit_' .. society,
      {
        css = 'job',
        title    = _U('recruiting'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'recruit_confirm_' .. society,
          {
            css = 'job',
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

              ESX.TriggerServerCallback('esx_society:setJob', function()
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

  ESX.TriggerServerCallback('esx_society:getJob', function(job)

    local elements = {}

    for i=1, #job.grades, 1 do
      local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
      table.insert(elements, {label = gradeLabel, value = job.grades[i].grade, selected = (employee.job.grade == job.grades[i].grade)})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'promote_employee_' .. society,
      {
        css = 'job',
        title    = _U('promote_employee', employee.name),
        elements = elements
      },
      function(data, menu)
        menu.close()

        TriggerEvent('esx:showNotification', _U('you_have_promoted', employee.name, data.current.label))

        ESX.TriggerServerCallback('esx_society:setJob', function()
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

  ESX.TriggerServerCallback('esx_society:getJob', function(job)

    local elements = {}

    for i=1, #job.grades, 1 do
      local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
      table.insert(elements, {label = gradeLabel .. ' $' .. job.grades[i].salary, value = job.grades[i].grade})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'manage_grades_' .. society,
      {
        css = 'job',
        title    = _U('salary_management'),
        elements = elements
      },
      function(data, menu)

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society,
          {
            css = 'job',
            title = _U('salary_amount')
          },
          function(data2, menu2)

            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu2.close()

              ESX.TriggerServerCallback('esx_society:setJobSalary', function()
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

function OpenManageStocksMenu(society, close)

  local elements = {
    {label = _U('get_stock'), value = 'get_stock'},
    {label = _U('put_stock'), value = 'put_stock'},
  }

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'boss_actions',
    {
      css = 'job',
      title    = _U('chest'),
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'get_stock' then
        OpenStocksMenu(society)
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksMenu(society)
      end

    end,
    function(data, menu)

      if close ~= nil then
        close(data, menu)
      end

    end
  )

end

function OpenStocksMenu(society)

  ESX.TriggerServerCallback('esx_society:getStockItems', function(items)

    local elements = {}

    for i=1, #items.standard, 1 do
      if items.standard[i].count > 0 then
        table.insert(elements, {label = 'x' .. items.standard[i].count .. ' ' .. items.standard[i].label, type = 'item_standard', value = items.standard[i].name})
      end
    end

    for i=1, #items.weapons, 1 do
      if items.weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. items.weapons[i].count .. ' ' .. ESX.GetWeaponLabel(items.weapons[i].name), type = 'item_weapon', value = items.weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'get_stocks_menu',
      {
        css = 'Inventaire',
        title    = _U('chest'),
        elements = elements
      },
      function(data, menu)

        local itemType = data.current.type
        local itemName = data.current.value

        if itemType == 'item_standard' then

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'get_stocks_menu_item_count',
            {
              css = 'Inventaire',
              title = _U('quantity')
            },
            function(data2, menu2)

              local count = tonumber(data2.value)

              if count == nil then
                ESX.ShowNotification(_U('invalid_quantity'))
              else
                
                menu2.close()
                menu.close()

                ESX.TriggerServerCallback('esx_society:getStockItem', function()
                  OpenStocksMenu(society)
                end, society, itemType, itemName, count)

              end

            end,
            function(data2, menu2)
              menu2.close()
            end
          )

        elseif itemType == 'item_weapon' then

          ESX.TriggerServerCallback('esx_society:getStockItem', function()
            OpenStocksMenu(society)
          end, society, itemType, itemName, 1)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, society)

end

function OpenPutStocksMenu(society)

  local playerPed  = GetPlayerPed(-1)
  local inventory  = ESX.GetPlayerData().inventory
  local weaponList = ESX.GetWeaponList()
  local elements   = {}

  -- item_standard
  for i=1, #inventory, 1 do

    local item = inventory[i]

    if item.count > 0 then
      table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
    end

  end

  -- item_weapon
  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      table.insert(elements, {label = weaponList[i].label .. ' x1', type = 'item_weapon', value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'put_stocks_menu',
    {
      css = 'Inventaire',
      title    = _U('inventory'),
      elements = elements
    },
    function(data, menu)

      local itemType = data.current.type
      local itemName = data.current.value

      if itemType == 'item_standard' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'put_stocks_menu_item_count',
          {
            css = 'Inventaire',
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              
              menu2.close()
              menu.close()

              ESX.TriggerServerCallback('esx_society:putStockItem', function()
                OpenPutStocksMenu(society)
              end, society, itemType, itemName, count)

            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      elseif itemType == 'item_weapon' then

        ESX.TriggerServerCallback('esx_society:putStockItem', function()
          OpenPutStocksMenu(society)
        end, society, itemType, itemName, 1)

      end

    end,
    function(data, menu)
      menu.close()
    end
  )

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  
  PlayerData = xPlayer

  DisableSocietyMoneyHUDElement()

  if PlayerData.job.grade_name == 'boss' then
    
    EnableSocietyMoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSocietyMoneyHUDElement(money)
    end, PlayerData.job.name)

  end

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

  PlayerData.job = job

  DisableSocietyMoneyHUDElement()

  if PlayerData.job.grade_name == 'boss' then
    
    EnableSocietyMoneyHUDElement()
  
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
      UpdateSocietyMoneyHUDElement(money)
    end, PlayerData.job.name)

  end

end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)

  if PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' and 'society_' .. PlayerData.job.name == society then
    UpdateSocietyMoneyHUDElement(money)
  end

end)

AddEventHandler('esx_society:openBossMenu', function(society, close, options)
  OpenBossMenu(society, close, options)
end)

AddEventHandler('esx_society:openStocksMenu', function(society, close)
  OpenManageStocksMenu(society, close)
end)
