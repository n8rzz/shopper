import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import _get from 'lodash/get';
import _orderBy from 'lodash/orderBy';
import ApiService from '../service/api.service';
import EventService from '../service/event.service';
import { CalendarContainer } from './calendar-container';
import { EventListContainer } from './event-list.container';
import { EVENT_NAME } from '../constants/event-names';

export class MealSchedulePage extends React.Component {
    constructor(props) {
        super(props);

        // a bit of a snapshot testing hack. allows for an external date
        // (like a test mock) to be passed as _'today'_
        const currentDate = _get(props, 'currentDate', new Date());

        this._onClickPreviousMonthHandler = this._onClickPreviousMonth.bind(this);
        this._onClickNextMonthHandler = this._onClickNextMonth.bind(this);
        this._onClickDayHandler = this._onClickDay.bind(this);
        this._onClickRemoveHandler = this._onClickRemove.bind(this);
        this._onClickRemoveScheduleSuccessHandler = this._onClickRemoveScheduleSuccess.bind(this);
        this._onClickAddScheduleToOrderHandler = this._onClickAddScheduleToOrder.bind(this);

        this.state = {
            currentDate: moment.utc(currentDate),
            eventsForCurrentMonth: this._buildEventListForCurrentMonth(moment.utc(currentDate), props.mealSchedules),
            mealSchedules: props.mealSchedules,
        };
    }

    componentWillUnmount() {
        this._onClickPreviousMonthHandler = null;
        this._onClickNextMonthHandler = null;
        this._onClickDayHandler = null;
        this._onClickRemoveHandler = null;
        this._onClickRemoveScheduleSuccessHandler = null;
        this._onClickAddScheduleToOrderHandler = null;
    }

    _getFullDateFromDayNumber(dayNumber) {
        return moment.utc(new Date(this.state.currentDate.year(), this.state.currentDate.month(), dayNumber));
    }

    _buildEventListForCurrentMonth(currentDate = null, mealSchedules) {
        const sortedSchedule = _orderBy(mealSchedules, 'schedule_date');
        const dateUsedForCurrentMonth = currentDate != null
            ? currentDate
            : this.state.currentDate;

        const eventsForCurrentMonth = sortedSchedule.filter(
            (schedule) => moment.utc(schedule.schedule_date).isSame(dateUsedForCurrentMonth, 'month'),
        );

        return eventsForCurrentMonth;
    }

    // TODO: combine with similar method
    _onClickPreviousMonth() {
        this.setState((prevState) => {
            const currentDate = prevState.currentDate.subtract(1, 'month');
            const eventsForCurrentMonth = this._buildEventListForCurrentMonth(currentDate);

            return {
                currentDate,
                eventsForCurrentMonth,
            };
        });
    }

    // TODO: combine with similar method
    _onClickNextMonth() {
        this.setState((prevState) => {
            const currentDate = prevState.currentDate.add(1, 'month');
            const eventsForCurrentMonth = this._buildEventListForCurrentMonth(currentDate);

            return {
                currentDate,
                eventsForCurrentMonth,
            };
        });
    }

    _onClickDay(/* event, dayNumber */) {
        // const selectedDay = this._getFullDateFromDayNumber(dayNumber);

        // console.log('+++', dayNumber, selectedDay, selectedDay.week());
    }

    _onClickRemove(mealScheduleId) {
        const destroyMealScheduleUrl = `/meal_schedules/${mealScheduleId}.json`;

        ApiService.delete(destroyMealScheduleUrl, this.props.csrf)
            .then((response) => {
                this._onClickRemoveScheduleSuccessHandler(response, mealScheduleId);
            })
            .catch((error) => {
                throw error;
            });
    }

    _onClickRemoveScheduleSuccess(response, mealScheduleId) {
        this.setState((prevState) => {
            const mealSchedules = prevState.mealSchedules.filter((schedule) => schedule.id !== mealScheduleId);
            const eventsForCurrentMonth = this._buildEventListForCurrentMonth(null, mealSchedules);

            return {
                eventsForCurrentMonth,
                mealSchedules,
            };
        });
    }

    _onClickAddScheduleToOrder(schedule) {
        if (schedule.isAssembly) {
            return this._addAssemblyToOrder(schedule);
        }

        return this._addItemToOrder(schedule);
    }

    _addAssemblyToOrder(schedule) {
        const addAssemblyToOrderUrl = '/order_items/create/assembly.json';
        const payload = {
            assembly_id: schedule.scheduleItem.id,
        };

        ApiService.post(addAssemblyToOrderUrl, payload, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    const errorNotice = `
                        Received an unexpected status code from ${addAssemblyToOrderUrl}: ${response.status}}
                    `;

                    EventService.emit(EVENT_NAME.NOTICE_ERROR, errorNotice);

                    return;
                }

                const notice = `${schedule.scheduleItem.name} added to order`;

                EventService.emit(EVENT_NAME.NOTICE_SUCCESS, notice);
            })
            .catch((error) => {
                throw error;
            });
    }

    _addItemToOrder(schedule) {
        const addItemToOrderUrl = '/order_items/create/item.json';
        const payload = {
            item_id: schedule.scheduleItem.id,
            department_id: schedule.scheduleItem.department_id,
        };

        ApiService.post(addItemToOrderUrl, payload, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    const errorNotice = `
                        Received an unexpected status code from ${addItemToOrderUrl}: ${response.status}}
                    `;

                    EventService.emit(EVENT_NAME.NOTICE_ERROR, errorNotice);

                    return;
                }

                const notice = `${schedule.scheduleItem.name} added to order`;

                EventService.emit(EVENT_NAME.NOTICE_SUCCESS, notice);
            })
            .catch((error) => {
                throw error;
            });
    }

    render() {
        return (
            <React.Fragment>
                <div className={'vr_3'}>
                    <CalendarContainer
                        currentDate={this.state.currentDate}
                        mealSchedules={this.state.eventsForCurrentMonth}
                        onClickPreviousMonthHandler={this._onClickPreviousMonthHandler}
                        onClickNextMonthHandler={this._onClickNextMonthHandler}
                        onClickDayHandler={this._onClickDayHandler}
                    />
                </div>
                <EventListContainer
                    assemblies={this.props.assemblies}
                    currentDate={this.state.currentDate}
                    items={this.props.items}
                    mealSchedules={this.state.eventsForCurrentMonth}
                    onClickAddScheduleToOrderHandler={this._onClickAddScheduleToOrderHandler}
                    onClickRemoveHandler={this._onClickRemoveHandler}
                />
            </React.Fragment>
        );
    }
}

MealSchedulePage.propTypes = {
    assemblies: PropTypes.object.isRequired,
    csrf: PropTypes.string.isRequired,
    items: PropTypes.object.isRequired,
    mealSchedules: PropTypes.array.isRequired,
};
