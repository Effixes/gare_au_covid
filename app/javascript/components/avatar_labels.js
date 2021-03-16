const initAvatarLabel = () => {
  const labelWrappers = document.querySelectorAll('.js-invited-avatar');

  const labelImgs = document.querySelectorAll('.js-invited-avatar .invited-avatar');

  labelWrappers.forEach((labelWrapper) => {
    const input = labelWrapper.querySelector('input');
    input.addEventListener('change', (event) => {
      labelImgs.forEach(img => img.classList.remove('active'));
      const labelImg = labelWrapper.querySelector('.invited-avatar');
      labelImg.classList.add('active');
    });
  });
}

const avatarPicker = () => {
    if (document.getElementById("switch-btn")) {
      const switchBtn = document.getElementById("switch-btn");
      let x = 1;
      switchBtn.addEventListener("click", function(e){
        const imgs = document.getElementById("imgs-container").getElementsByTagName('span');
        e.preventDefault();
        let randImg = imgs[Math.floor(Math.random() * imgs.length)];
        randImg.getElementsByClassName('input-avatar')[0].checked = true;
        randImg.style.zIndex = x;
        x++;
    });
  }
}

export { initAvatarLabel };
export { avatarPicker };
