import _groupBy from 'lodash/groupBy';

export const mealScheduleItemMock = {
    id: 1,
    schedule_date: '2019-09-24T00:00:00.000Z',
    purchased: false,
    created_at: '2019-09-04T01:00:35.645Z',
    updated_at: '2019-09-04T01:00:35.645Z',
    item_id: 15,
    order_item_id: null,
    assembly_id: null,
    meal_time: 'none',
};

export const mealScheduleAssemblyMock = {
    id: 2,
    schedule_date: '2019-09-24T00:00:00.000Z',
    purchased: false,
    created_at: '2019-09-04T01:00:35.645Z',
    updated_at: '2019-09-04T01:00:35.645Z',
    item_id: null,
    order_item_id: null,
    assembly_id: 2,
    meal_time: 'none',
};

export const mealScheduleListMock = [
    mealScheduleItemMock,
    mealScheduleAssemblyMock,
    {
        id: 3,
        schedule_date: '2019-09-29T00:00:00.000Z',
        purchased: false,
        created_at: '2019-09-03T01:00:35.645Z',
        updated_at: '2019-09-07T01:00:35.645Z',
        item_id: null,
        order_item_id: null,
        assembly_id: 2,
        meal_time: 'none',
    },
];

export const mealScheduleMapMock = _groupBy(mealScheduleListMock, 'schedule_date');
