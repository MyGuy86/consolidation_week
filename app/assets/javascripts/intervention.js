document.addEventListener('DOMContentLoaded', function (e) {
    const customer = document.getElementById('customer')
    const building = document.getElementById('building')
    const battery = document.getElementById('battery')
    const column = document.getElementById('column')
    const elevator = document.getElementById('elevator')
  
    // add the 'Building' option tag back in the HTML w/ dynamic values of ID and whats visible
    const defaultBuilding = (id, html) => {
       let opt = document.createElement('option')
       opt.value = id
       opt.innerHTML = html
       building.appendChild(opt)
    }
    const defaultBattery = (id, html) => {
      let opt = document.createElement('option')
      opt.value = id
      opt.innerHTML = html
      battery.appendChild(opt)
   }
   const defaultColumn = (id, html) => {
      let opt = document.createElement('option')
      opt.value = id
      opt.innerHTML = html
      column.appendChild(opt)
   }
   const defaultElevator = (id, html) => {
      let opt = document.createElement('option')
      opt.value = id
      opt.innerHTML = html
      elevator.appendChild(opt)
   }
 
    // removing all the option tags for building
    const removeBuildingOptions = () => {
       while (building.options.length != 0) {
          building.remove(0)
       }
    }
    const removeBatteryOptions = () => {
      while (battery.options.length != 0) {
         battery.remove(0)
      }
   }
   const removeColumnOptions = () => {
      while (column.options.length != 0) {
         column.remove(0)
      }
   }
   const removeElevatorOptions = () => {
      while (elevator.options.length != 0) {
         elevator.remove(0)
      }
   }
 
    // when first loaded, all buildings will be displayed in the building dropdown
    // this will remove everything
    if (building.value === '') {
       removeBuildingOptions()
       defaultBuilding(0, 'Building')
    }
    // when first loaded, all batteries will be displayed in the battery dropdown
    // this will remove everything
    if (battery.value === '') {
      removeBatteryOptions()
      defaultBattery(0, 'Battery')
   }
    // when first loaded, all columns will be displayed in the column dropdown
    // this will remove everything
   if (column.value === '') {
      removeColumnOptions()
      defaultColumn(0, 'Column')
   }
    // when first loaded, all elevators will be displayed in the elevator dropdown
    // this will remove everything
   if (elevator.value === '') {
      removeElevatorOptions()
      defaultElevator(0, 'Elevator')
   }

    // change event on the customer dropdown
    customer.addEventListener('change', (e) => {
       let id_value_string = e.target.value
       // a reset, if user selects default then we will remove everything and default back
       if (
          id_value_string === '' ||
          id_value_string === null ||
          id_value_string === 0
       ) {
          removeBuildingOptions()
          defaultBuilding(0, 'Building')
       } else {
          // fetch will call the controller which holds our data
          fetch(`/get_building_by_customer/${e.target.value}`)
             .then((response) => response.json())
             .then((data) => {
                removeBuildingOptions()
                defaultBuilding(0, 'Building')
                // loop through all our data and display only buildings we need
                data.forEach((obj) => {
                   defaultBuilding(obj.id, "stupid bitch " + obj.id)
                })
             })
             .catch((error) => console.log(error))
       }
    })

    // change event on the building dropdown
    building.addEventListener('change', (e) => {
      let id_value_string = e.target.value
      // a reset, if user selects default then we will remove everything and default back
      if (
         id_value_string === '' ||
         id_value_string === null ||
         id_value_string === 0
      ) {
         removeBatteryOptions()
         defaultBattery(0, 'Battery')
      } else {
         // fetch will call the controller which holds our data
         fetch(`/get_battery_by_building/${e.target.value}`)
            .then((response) => response.json())
            .then((data) => {
               removeBatteryOptions()
               defaultBattery(0, 'Battery')
               // loop through all our data and display only battery we need
               data.forEach((obj) => {
                  defaultBattery(obj.id, "bitchass " + obj.id)
               })
            })
            .catch((error) => console.log(error))
      }
   })


    // change event on the battery dropdown
    battery.addEventListener('change', (e) => {
      let id_value_string = e.target.value
      // a reset, if user selects default then we will remove everything and default back
      if (
         id_value_string === '' ||
         id_value_string === null ||
         id_value_string === 0
      ) {
         removeColumnOptions()
         defaultColumn(0, 'Column')
      } else {
         // fetch will call the controller which holds our data
         fetch(`get_column_by_battery/${e.target.value}`)
            .then((response) => response.json())
            .then((data) => {
               removeColumnOptions()
               defaultColumn(0, 'Column')
               // loop through all our data and display only columns we need
               data.forEach((obj) => {
                  defaultColumn(obj.id, "fuck face " + obj.id)
               })
            })
            .catch((error) => console.log(error))
      }
   })


    // change event on the column dropdown
    column.addEventListener('change', (e) => {
      let id_value_string = e.target.value
      // a reset, if user selects default then we will remove everything and default back
      if (
         id_value_string === '' ||
         id_value_string === null ||
         id_value_string === 0
      ) {
         removeElevatorOptions()
         defaultElevator(0, 'Elevator')
      } else {
         // fetch will call the controller which holds our data
         fetch(`/get_elevator_by_column/${e.target.value}`)
            .then((response) => response.json())
            .then((data) => {
               removeElevatorOptions()
               defaultElevator(0, 'Elevator')
               // loop through all our data and display only elevators we need
               data.forEach((obj) => {
                  defaultElevator(obj.id, "stupid bitch " + obj.id)
               })
            })
            .catch((error) => console.log(error))
      }
   })
})

 