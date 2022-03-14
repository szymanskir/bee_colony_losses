registerSelectInput = (inputId) => {
  const selectInput = document.getElementById(inputId);
  
  selectInput.addEventListener("change", (event) => {
    const selectedValue = event.target.value;
    Shiny.setInputValue(inputId, selectedValue, { priority: "event" });
  })
}

updateSelectInput = (message) => {
  const selectInputId = message.id;  
  const values = message.values;
  
  const selectInput = document.getElementById(selectInputId);
  values.forEach((value) => {
    const option = document.createElement("option");
    option.value = value;
    option.innerHTML = value;
    
    selectInput.appendChild(option);
  })
  
  selectInput.value = values[0];
  selectInput.dispatchEvent(new Event('change'));
}

$( document ).ready(function() {
  registerSelectInput("state");
  registerSelectInput("stressor_type");
  registerSelectInput("year_month");
  
  Shiny.addCustomMessageHandler("updateSelectInputOptions", updateSelectInput);
})