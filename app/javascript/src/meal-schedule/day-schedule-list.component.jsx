import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import _groupBy from 'lodash/groupBy';
import { ScheduleItem } from './schedule-item.component';

export class DayScheduleList extends React.Component {
    _buildMealScheduleItemsForDay(mealTimeItem, itemIndex) {
        let isAssembly = false;
        let scheduleItem = this.props.items[mealTimeItem.item_id];

        if (mealTimeItem.item_id == null) {
            isAssembly = true;
            scheduleItem = this.props.assemblies[mealTimeItem.assembly_id];
        }

        return (
            <ScheduleItem
                key={`eventItem-${scheduleItem.name}-${itemIndex}`}
                mealScheduleId={mealTimeItem.id}
                scheduleItem={scheduleItem}
                isAssembly={isAssembly}
                onClickAddScheduleToOrderHandler={this.props.onClickAddScheduleToOrderHandler}
                onClickRemoveHandler={this.props.onClickRemoveHandler}
            />
        );
    }

    _buildMealScheduleItemListForDay(daySchedule) {
        const schedulesForDay = this.props.mealScheduleMap[daySchedule];
        const itemsByMealTime = _groupBy(schedulesForDay, 'meal_time');

        return Object.keys(itemsByMealTime).map((mealTime, itemIndex) => {
            const items = itemsByMealTime[mealTime].map(
                (mealTimeItem) => this._buildMealScheduleItemsForDay(mealTimeItem, itemIndex),
            );

            return (
                <ul
                    key={`mealSchedule-${daySchedule}-${mealTime}`}
                    className={`mealSchedule-bd-itemList mealSchedule-bd-itemList_${mealTime}`}
                >
                    {items}
                </ul>
            );
        });
    }

    render() {
        const formattedDate = moment.utc(this.props.daySchedule).format('Do');
        const mealScheduleItemsForDay = this._buildMealScheduleItemListForDay(this.props.daySchedule);

        return (
            <li className={'eventList-bd-item'}>
                <div className={'mealSchedule'}>
                    <div className={'mealSchedule-hd'}>
                        {formattedDate}
                    </div>
                    <div className={'mealSchedule-bd'}>
                        {mealScheduleItemsForDay}
                    </div>
                </div>
            </li>
        );
    }
}

DayScheduleList.propTypes = {
    assemblies: PropTypes.object.isRequired,
    daySchedule: PropTypes.string.isRequired,
    items: PropTypes.object.isRequired,
    // TODO: may make more sense to build in this component
    mealScheduleMap: PropTypes.object.isRequired,
    onClickAddScheduleToOrderHandler: PropTypes.func.isRequired,
    onClickRemoveHandler: PropTypes.func.isRequired,
};
