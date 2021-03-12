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

export { initAvatarLabel };
