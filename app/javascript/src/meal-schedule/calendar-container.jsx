import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import classnames from 'classnames';
import { CalendarDay } from './calendar-day.component';

export class CalendarContainer extends React.Component {
    constructor(props) {
        super(props);

        this._today = moment(new Date()).startOf('day');
        this._weekdayShortNames = moment.weekdaysShort();
        this._onClickCalendarHeaderHandler = this._onClickCalendarHeader.bind(this);
        this.state = {
            isCalendarBodyHidden: false,
        };
    }

    componentWillUnmount() {
        this._onClickCalendarHeaderHandler = null;
    }

    _getfirstDayOfCurrentMonth() {
        return this.props.currentDate
            .startOf('month')
            .format('d');
    }

    _getCurrentMonthName() {
        return moment.utc(this.props.currentDate).format('MMM');
    }

    _getCurrentYear() {
        return moment.utc(this.props.currentDate).format('YYYY');
    }

    _findMealScheduleForDay(day = []) {
        if (day.length === 0) {
            return [];
        }

        return this.props.mealSchedules.filter(
            (schedule) => day.format('DD/MM') === moment.utc(schedule.schedule_date).format('DD/MM'),
        );
    }

    _isEventDayToday(eventDate) {
        return eventDate.clone().startOf('day').isSame(this._today, 'd');
    }

    _hasEventOnDay(day) {
        const foundEvent = this._findMealScheduleForDay(day);

        return typeof foundEvent.length > 0;
    }

    _buildTableBodyClassnames() {
        return classnames({
            'calendar-bd': true,
            'u-isVisuallyHidden': this.state.isCalendarBodyHidden,
        });
    }

    _buildTableHeadJsx() {
        return this._weekdayShortNames.map((day) => (
            <th
                className={'calendarTable-th'}
                key={`weekdayHeader-${day}`}
            >
                {day}
            </th>
        ));
    }

    _buildBlankCellJsx(numberOfCells = -1) {
        const blankCellListJsx = [];
        const cellCount = numberOfCells !== -1
            ? numberOfCells
            : this._getfirstDayOfCurrentMonth();

        // eslint-disable-next-line no-plusplus
        for (let i = 0; i < cellCount; i++) {
            const blankCellJsx = (
                <td
                    key={`blankDay-${i}`}
                    className={'calendarTable-td'}
                >
                    <div className={'calendarTable-td-cell mix-calendarTable-td-cell_isEmpty'}>
                        &nbsp;
                    </div>
                </td>
            );

            blankCellListJsx.push(blankCellJsx);
        }

        return blankCellListJsx;
    }

    _buildCalendarCellsJsx() {
        const calendarDaysJsx = [];

        // eslint-disable-next-line no-plusplus
        for (let dayNumber = 1; dayNumber <= this.props.currentDate.daysInMonth(); dayNumber++) {
            const rawDate = new Date(this.props.currentDate.year(), this.props.currentDate.month(), dayNumber);
            const eventDate = moment.utc(rawDate);
            // FIXME: could be multiple, fix this
            const mealScheduleForDay = this._findMealScheduleForDay(eventDate);

            const calendarDayJsx = (
                <CalendarDay
                    key={`calendarDay-${dayNumber}`}
                    isToday={this._isEventDayToday(eventDate)}
                    dayNumber={dayNumber}
                    mealScheduleForDay={mealScheduleForDay}
                    onClickDayHandler={this.props.onClickDayHandler}
                />
            );

            calendarDaysJsx.push(calendarDayJsx);
        }

        return calendarDaysJsx;
    }

    _buildTableBodyJsx() {
        const blankDaysJsx = this._buildBlankCellJsx();
        const daysInMonth = this._buildCalendarCellsJsx();
        const totalSlots = [...blankDaysJsx, ...daysInMonth];
        const rows = [];
        let cells = [];

        // FIXME: rework this, there should be a better way
        totalSlots.forEach((row, i) => {
            if (i % 7 === 0) {
                // when reach next week we contain all td in last week to rows
                rows.push(cells);
                cells = [];
                // in current loop we still push current row to new container
                cells.push(row);
            } else {
                cells.push(row);
            }

            if (i === totalSlots.length - 1) {
                const remainingEmptyCells = 7 - cells.length;

                rows.push([
                    ...cells,
                    ...this._buildBlankCellJsx(remainingEmptyCells),
                ]);
            }
        });

        return rows.map((rowJsx, i) => (<tr key={`calendar-row-${i}`}>{rowJsx}</tr>));
    }

    _onClickCalendarHeader() {
        this.setState((prevState) => ({ isCalendarBodyHidden: !prevState.isCalendarBodyHidden }));
    }

    render() {
        return (
            <div className={'calendar'}>
                <div className={'calendar-hd'}>
                    <div className={'calendar-hd-btn'}>
                        <button
                            type={'button'}
                            className={'btn'}
                            onClick={this.props.onClickPreviousMonthHandler}
                        >
                            &lt;
                        </button>
                    </div>
                    <div
                        className={'calendar-hd-title'}
                        onClick={this._onClickCalendarHeaderHandler}
                    >
                        {this._getCurrentMonthName()} - {this._getCurrentYear()}
                    </div>
                    <div className={'calendar-hd-btn'}>
                        <button
                            type={'button'}
                            className={'btn'}
                            onClick={this.props.onClickNextMonthHandler}
                        >
                            &gt;
                        </button>
                    </div>
                </div>
                <div className={this._buildTableBodyClassnames()}>
                    <table className={'calendarTable'}>
                        <thead>
                            <tr>{this._buildTableHeadJsx()}</tr>
                        </thead>
                        <tbody>{this._buildTableBodyJsx()}</tbody>
                    </table>
                </div>
            </div>
        );
    }
}

CalendarContainer.propTypes = {
    currentDate: PropTypes.object.isRequired,
    mealSchedules: PropTypes.array.isRequired,
    onClickPreviousMonthHandler: PropTypes.func.isRequired,
    onClickNextMonthHandler: PropTypes.func.isRequired,
    onClickDayHandler: PropTypes.func.isRequired,
};
