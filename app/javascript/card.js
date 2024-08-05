const pay = () => {
  const payjp = Payjp('pk_test_cfd037bca15d148981029a70');
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 各要素を指定した HTML 要素にマウントする
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  const errorMessageElement = document.getElementById('error-message'); // エラーメッセージ要素を取得

  if (form) {
    form.addEventListener("submit", (e) => {
      e.preventDefault();

      payjp.createToken(numberElement).then((response) => {
        if (response.error) {
          console.error('Token creation error:', response.error);
          // エラーメッセージを表示する
          if (errorMessageElement) {
            errorMessageElement.textContent = `エラー: ${response.error.message}`;
            errorMessageElement.style.display = 'block'; // エラーメッセージを表示
          }
        } else {
          const token = response.id;
          const tokenInput = document.createElement('input');
          tokenInput.setAttribute('type', 'hidden');
          tokenInput.setAttribute('name', 'token');
          tokenInput.setAttribute('value', token);
          form.appendChild(tokenInput);

          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();

          // フォームを再送信
          form.submit();
        }
      }).catch((error) => {
        console.error('Token creation failed:', error);
        if (errorMessageElement) {
          errorMessageElement.textContent = 'トークンの作成中に予期しないエラーが発生しました。再度お試しください。';
          errorMessageElement.style.display = 'block'; // エラーメッセージを表示
        }
      });
    });
  } else {
    console.error('Form element not found');
    if (errorMessageElement) {
      errorMessageElement.textContent = 'フォームが見つかりませんでした。';
      errorMessageElement.style.display = 'block'; // エラーメッセージを表示
    }
  }
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);