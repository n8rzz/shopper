export function extractLocationNameFromMapByLocationId(order, locationMap) {
    const locationId = order.location_id;
    const locationName = locationMap[locationId].name;

    if (typeof locationName === 'undefined') {
        return '';
    }

    return locationName;
}
