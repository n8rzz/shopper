import React from 'react';
import PropTypes from 'prop-types';
import _groupBy from 'lodash/groupBy';
import { DayScheduleList } from './day-schedule-list.component';

// FIXME: this probably isn't a container
export class EventListContainer extends React.Component {
    constructor(props) {
        super(props);

        this._itemMap = null;

        this._groupMealShcedulesByScheduleDate(props);
    }

    componentWillReceiveProps(nextProps) {
        this._groupMealShcedulesByScheduleDate(nextProps);
    }

    _groupMealShcedulesByScheduleDate(props) {
        this._mealScheduleMap = _groupBy(props.mealSchedules, 'schedule_date');
    }

    _buildEventListJsx() {
        return Object.keys(this._mealScheduleMap).map((daySchedule, index) => (
            <DayScheduleList
                key={`daysSchedule-${index}`}
                assemblies={this.props.assemblies}
                daySchedule={daySchedule}
                items={this.props.items}
                mealScheduleMap={this._mealScheduleMap}
                onClickAddScheduleToOrderHandler={this.props.onClickAddScheduleToOrderHandler}
                onClickRemoveHandler={this.props.onClickRemoveHandler}
            />
        ));
    }

    render() {
        const eventListJsx = this._buildEventListJsx();

        return (
            <div className={'eventList'}>
                <div className={'stereo'}>
                    <h3 className={'eventList-hd'}>
                        {this.props.currentDate.format('MMMM')}
                    </h3>
                    <div>
                        <a
                            className={'link'}
                            href={'meal_schedules/new'}
                        >
                            New Schedule
                        </a>
                    </div>
                </div>
                <ul className={'eventList-bd'}>
                    {eventListJsx}
                </ul>
            </div>
        );
    }
}

EventListContainer.propTypes = {
    assemblies: PropTypes.object.isRequired,
    currentDate: PropTypes.object.isRequired,
    items: PropTypes.object.isRequired,
    // eslint-disable-next-line react/no-unused-prop-types
    mealSchedules: PropTypes.array.isRequired,
    onClickAddScheduleToOrderHandler: PropTypes.func.isRequired,
    onClickRemoveHandler: PropTypes.func.isRequired,
};
