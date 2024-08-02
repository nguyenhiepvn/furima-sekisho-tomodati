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

  if (form) {
    // フォーム送信時の処理
    form.addEventListener("submit", (e) => {

      // デフォルトの送信動作をキャンセル
      e.preventDefault();
      payjp.createToken(numberElement).then((response) => {
        if (response.error) {
          // エラーハンドリング
          console.error('Token creation error:', response.error);
          alert(response.error.message); 
        } else {
           // トークンが成功して取得できた場合
          const token = response.id;
          const tokenInput = document.createElement('input');
          tokenInput.setAttribute('type', 'hidden');
          tokenInput.setAttribute('name', 'token');
          tokenInput.setAttribute('value', token);
          form.appendChild(tokenInput);
          
          // クレジットカード情報のフィールドを空にする
          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();

          // フォームを再送信
          form.submit();
        }
      }).catch((error) => {
        console.error('Token creation failed:', error);
        alert('トークンの作成に失敗しました。');
      });
    });
  } else {
    
    // フォームが見つからない場合
    console.error('Form element not found');
  }
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);