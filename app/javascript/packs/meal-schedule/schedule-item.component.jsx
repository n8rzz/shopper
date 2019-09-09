import React from 'react';
import PropTypes from 'prop-types';

function onClickRemove(event, props) {
    event.preventDefault();
    props.onClickRemoveHandler(props.mealScheduleId);
}

function onClickAddScheduleToOrder(event, props) {
    event.preventDefault();
    props.onClickAddScheduleToOrderHandler(props);
}

export function ScheduleItem(props) {
    return (
        <li className={'mealSchedule-bd-itemList-item'}>
            <ul className={'stereo'}>
                <li>
                    <a
                        className={'link'}
                        href={`meal_schedules/${props.mealScheduleId}/edit`}
                    >
                        {props.scheduleItem.name}
                    </a>
                </li>
                <li>
                    <ul className={'hlist'}>
                        <li>
                            <button
                                type={'button'}
                                className={`icon-btn qa-scheduleItem-addToOrder-${props.mealScheduleId}`}
                                onClick={(event) => onClickAddScheduleToOrder(event, props)}
                            >
                                <span className={'icon icon-cart-check'} />
                            </button>
                        </li>
                        <li>
                            <button
                                type={'button'}
                                className={'icon-btn js-mealSchedule-remove'}
                                onClick={(event) => onClickRemove(event, props)}
                            >
                                <span className={'icon icon-trashcan'} />
                            </button>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
    );
}

ScheduleItem.propTypes = {
    // eslint-disable-next-line react/no-unused-prop-types
    isAssembly: PropTypes.bool.isRequired,
    // eslint-disable-next-line react/no-unused-prop-types
    mealScheduleId: PropTypes.number.isRequired,
    scheduleItem: PropTypes.object.isRequired,
    // eslint-disable-next-line react/no-unused-prop-types
    onClickAddScheduleToOrderHandler: PropTypes.func.isRequired,
    // eslint-disable-next-line react/no-unused-prop-types
    onClickRemoveHandler: PropTypes.func.isRequired,
};
