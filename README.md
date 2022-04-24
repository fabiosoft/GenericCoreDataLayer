# Generic DB Core Data Layer


This Swift project is focused on creating a reusable and generic database (DB) layer and how to execute a specific implementation, in this case, Core Data.

## Step One: Prepare a Generic DB Layer

- Any entity that needs to be saved to the database should implement the Storable protocol.
- CoreDataStoreCoordinator is the class responsible for the initialization of the database and setting up all the prerequisites.
- StorageContext: Generic DB Layer

## Step Two: Create a Specific Implementation of the DB Layer

- CoreDataStorageContext is the implementation of the StorageContext. 

## Step three: Mapping

- All our domain entities should implement the Mappable protocol.
Domain entities and database entities should be different. View controllers and the business (service) layer should not know about  the view controller should not know what a NSManagedObject is.
- I created a base entity for all of my domain entities. All domain entities should inherit from this DomainBaseEntity
- Mapper, which maps the entities from domain to DB and viceversa. (I used the Runtime library for iterating over the properties and copying them from the domain entity to a DB entity and vice versa)

## Data Access Object (DAO)

- BaseDao is the parent of all the data access object (DAO) classes. It has methods that can be performed on the StorageContext. It declares the StorageContext as a dependency. You can pass any implementation of StorageContext here, for example, CoreDataStorageContext or RealmStorageContext. You will see that BaseDao expects two types of entities: Domain and DB. DomainEntity should be of type Mappable while DBEntity should conform to protocol Storable. These entities are required for mapping between domain and DB entities.
- DBManager to initialize the required DAOs. We need to provide the StorageContext implementation while initializing the DAO classes. StorageContext is the dependency for DBManager and should be set before calling any DAO. Subclass this, and add DAOs as (eventually lazy) properties. The ideal place to provide the StorageContext implementation is at the start of the app. However, it can be changed depending on your needs.

---

## Example: Story
This specific example has its own branch, different from the main.

- Created a new entity into core data model: `StoryEntity`

```
public class StoryEntity: NSManagedObject {}

extension StoryEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryEntity> {
        return NSFetchRequest<StoryEntity>(entityName: "StoryEntity")
    }

    @NSManaged public var storyNumber: String?
    @NSManaged public var title: String?

}
```

```
class Story: DomainBaseEntity, Codable {
    // Codable interface is for automatic mapping
    var storyNumber: String?
    var title: String?
}

```

- This is a specific StoryDao which subclasses the BaseDao. Every subclass of BaseDao should provide the Domain and DB entity. In the case of StoryDao the Domain entity is Story and the DBentity is StoryEntity. I prefer to create a different DAO for every entity/database table.

```
class StoryDao: BaseDao<Story, StoryEntity> {
	.
	.
	.
}
```

- StoryDBManager to init all DAOs with specific context implementation

```
class StoryDBManager : DBManager {
    lazy var storyDao = StoryDao(storageContext: storageContextImpl())
    .
    .
}
```