import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import { MEAL_TIME_NAME } from '../constants/meal-time-names';

const DEFAULT_MEAL_TIME_MAP = {
    [MEAL_TIME_NAME.NONE]: null,
    [MEAL_TIME_NAME.MORNING]: null,
    [MEAL_TIME_NAME.AFTERNOON]: null,
    [MEAL_TIME_NAME.EVENING]: null,
};

export class CalendarDay extends React.Component {
    constructor(props) {
        super(props);

        // TODO: this may be better placed in a `state` var
        this._mealTimeMap = Object.create(DEFAULT_MEAL_TIME_MAP);
    }

    componentWillReceiveProps() {
        this._resetMealTimeMap();
    }

    componentWillUnmount() {
        this._resetMealTimeMap();
    }

    _resetMealTimeMap() {
        this._mealTimeMap = Object.create(DEFAULT_MEAL_TIME_MAP);
    }

    _buildClassnamesForCalendarDayCell() {
        return classnames({
            'calendarTable-td-cell': true,
            [`qa-calendarTable-td-cell-${this.props.dayNumber}`]: true,
            'mix-calendarTable-td-cell_isToday': this.props.isToday,
        });
    }

    _buildClassnamesForTimeIndicator(mealSchedule) {
        return classnames({
            'timeIndicator-item': mealSchedule != null && mealSchedule.meal_time === MEAL_TIME_NAME.NONE,
            'timeIndicator-item_morning': mealSchedule.meal_time === MEAL_TIME_NAME.MORNING,
            'timeIndicator-item_afternoon': mealSchedule.meal_time === MEAL_TIME_NAME.AFTERNOON,
            'timeIndicator-item_evening': mealSchedule.meal_time === MEAL_TIME_NAME.EVENING,
            'u-isVisuallyHidden': mealSchedule == null,
        });
    }

    _buildMealTimeIndicatorMapJsx() {
        if (this.props.mealScheduleForDay.length === 0) {
            return;
        }

        this.props.mealScheduleForDay.forEach((mealSchedule, i) => {
            const isTimeslotActive = this._mealTimeMap[mealSchedule.meal_time] !== null;

            if (isTimeslotActive) {
                return;
            }

            this._mealTimeMap[mealSchedule.meal_time] = (
                <li
                    className={this._buildClassnamesForTimeIndicator(mealSchedule)}
                    key={`mealSchedule-${mealSchedule.id}-${i}`}
                />
            );
        });
    }

    _buildMealTimeIndicatorListJsx() {
        return Object.keys(DEFAULT_MEAL_TIME_MAP).map((mealTimeName) => this._mealTimeMap[mealTimeName]);
    }

    render() {
        this._buildMealTimeIndicatorMapJsx();

        return (
            <td
                className={'calendarTable-td'}
                key={`calendar-day-${this.props.dayNumber}`}
            >
                <div
                    className={this._buildClassnamesForCalendarDayCell()}
                    onClick={(event) => this.props.onClickDayHandler(event, this.props.dayNumber)}
                >
                    <div>
                        {this.props.dayNumber}
                    </div>
                    <ul className={'timeIndicator'}>
                        {this._buildMealTimeIndicatorListJsx()}
                    </ul>
                </div>
            </td>
        );
    }
}

CalendarDay.propTypes = {
    dayNumber: PropTypes.number.isRequired,
    mealScheduleForDay: PropTypes.array,
    isToday: PropTypes.bool.isRequired,
    onClickDayHandler: PropTypes.func.isRequired,
};

CalendarDay.defaultProps = {
    mealScheduleForDay: [],
};
