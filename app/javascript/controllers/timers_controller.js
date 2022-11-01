import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    let dead = this.element.children[2];
    let deadline = dead.getAttribute('value');
    const id = this.element.children[2].id;
    const status_id = this.element.children[3];
    const starting_price = this.element.children[4];
    const buy_now = this.element.children[5];
    const elem = this.element;
    console.log(elem)
    // Сколько осталось времени
    function getTimeRemaining(endtime) {
        // Получаем разницу. Переводим конечную дату в миллисекунды и отнимаем текущую дату
        let t = Date.parse(endtime) - Date.now(),
        // Высчитываем секунды, минуты, часы и дни
            seconds = Math.floor((t/1000) % 60),
            minutes = Math.floor((t/1000/60) % 60),
            hours = Math.floor((t/1000/60/60) % 24),
            days = Math.floor((t/1000/60/60/24));

            return {
            'total': t,
            'seconds': seconds,
            'minutes': minutes,
            'hours': hours,
            'days': days
            };
    }

    // Форматируем и устанавливаем значения в разметку
    function setClock(id, endtime) {
        // Получаем блок таймера по его id
        let timer = document.getElementById(id),
        // И соотвественно, все элементы блока
            days = timer.querySelector('.days'),
            dayname = timer.querySelector('.dayname'),
            hours = timer.querySelector('.hours'),
            minutes = timer.querySelector('.minutes'),
            seconds = timer.querySelector('.seconds'),
            // Обновляем таймер каждую секунду
            timeInterval = setInterval(updateClock, 1000);

            // Функция для обновления таймера
            function updateClock() {
                // Помещаем в t результат функции getTimeRemaining (объект)
                let t = getTimeRemaining(endtime);
                // Если дней осталось 0 - не выводим
                if (t.days <= 0) {
                    days.textContent = "";
                    dayname.textContent = "";
                } else {
                    days.textContent = t.days;
                // Вставляем слово "день" при этом форматируя (дней, дня)
                    dayname.textContent = formatDays(t.days);                    
                }
                // Вставляем оставшееся время
                hours.textContent = formatTime(t.hours);
                minutes.textContent = formatTime(t.minutes);
                seconds.textContent = formatTime(t.seconds);

                // Если Дедлайн прошёл - вставляем в таймер 00:00:00,
                // и останавливаем отсчёт (clearInterval)
                if (t.total <= 0) {
                  setStatus();
                    clearInterval(timeInterval);
                    days.textContent = "";
                    hours.textContent = '00';
                    minutes.textContent = '00';
                    seconds.textContent = '00';
                }
            }

            // Функция добавляет 0 к единцам, получаем
            // 03:04:05 вместо 3:4:5
            function formatTime(time){
                if ( time < 10) {
                    time = '0' + time;
                }
                return time;
            }

            // Форматируем слово день в зависимости от числа
            // 1 день, 2 дня, 5 дней.
            function formatDays(day) {
                let sb = '',
                    dayNew = day % 100,
                    lastFigure = dayNew % 10;
                if (dayNew > 10 && dayNew < 20) {
                  sb = 'дней';
                }
                else if (lastFigure == 1) {
                  sb = "день";
                }
                else if (lastFigure > 1 && lastFigure < 5) {
                  sb = 'дня';
                }
                else {
                  sb = 'дней';
                }
                return sb;
            }

            function setStatus() {
                const formData = new FormData();
                formData.append('product[status_id]', 3 );
                doPatch('/api/products/3', formData);
                status_id.innerHTML = "Auction completed";
                const childElems = elem.getElementsByTagName('a');
                console.log(childElems)
                for (var el of childElems) {
                        el.removeAttribute("href");
                    };
                const childElemsButton = elem.getElementsByTagName('button');
                console.log(childElemsButton)
                for (var el of childElemsButton) {
                        el.removeAttribute("data-bs-target");
                    }

                // const status = document.createElement("p");
                // status.innerHTML = "Auction completed";
                // starting_price.innerHTML = "Auction completed";
                // buy_now.innerHTML = "Auction completed";
                // status.classList = "me-3 mb-1"
                // document.getElementById(id).appendChild(status)
            }

            async function doPatch(url, body) {
              const csrfToken = document.getElementsByName('csrf-token')[0].content

              await fetch(url, {
                method: 'PATCH',
                body: body,
                headers: {
                  "X-CSRF-Token": csrfToken
                }
              })
            }
    }

//Вызов таймера. Передаём id элемента и наш Дедлайн
    setClock(id, deadline);
  }
}