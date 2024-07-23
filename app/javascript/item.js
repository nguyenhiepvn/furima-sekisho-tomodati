
document.addEventListener("turbo:load", function() {
  setupPriceCalculator();
  initializePrice();
  checkForErrors();

});

document.addEventListener("turbo:render", function() {
  setupPriceCalculator();
  initializePrice();
  checkForErrors();

});

function setupPriceCalculator() {
  document.removeEventListener("input", handlePriceInput);
  document.addEventListener("input", handlePriceInput);
}

function initializePrice() {
  const priceInput = document.getElementById("item-price");
  if (priceInput && priceInput.value) {
    calculatePrice(priceInput.value);
  }
}

function handlePriceInput(event) {
  if (event.target.id === "item-price") {
    calculatePrice(event.target.value);
  }
}

function calculatePrice(inputValue) {
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  const taxRate = 0.1; // 10%

  if (inputValue && !isNaN(inputValue)) {
     const price = parseInt(inputValue, 10);
      const tax = Math.floor(price * taxRate);
      const calculatedProfit = price - tax;

      addTaxPrice.innerHTML = formatNumber(tax);
      profit.innerHTML = formatNumber(calculatedProfit);
    
  } else {
    clearPriceInfo();
  }
}

function clearPriceInfo() {
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  
  addTaxPrice.innerHTML = '';
  profit.innerHTML = '';
}

function formatNumber(num) {
  return num.toLocaleString('ja-JP');
}
function checkForErrors() {
  const errorExplanation = document.getElementsByClassName("error-alert");
  if (errorExplanation) {
    clearPriceInfo();
    // const priceInput = document.getElementById("item-price").value;
    // if (priceInput) {
    //   priceInput.value = '';
    // }
  }
}