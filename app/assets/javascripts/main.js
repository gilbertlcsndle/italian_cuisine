window.addEventListener("load", () => {
  const booking = document.querySelector("#booking");
  const container = document.querySelector(".container");

  booking.style.setProperty("--md-height", `${container.clientHeight + 45}px`);

  document.querySelector("form").addEventListener("submit", (e) => {
    e.target.querySelector(".submit-btn").innerHTML = "Loading";
  });
});
